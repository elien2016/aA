require 'sqlite3'
require 'singleton'

class QuestionDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :fname, :lname
  attr_reader :id
  
  def self.find_by_id(id)
    arr = QuestionDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    raise "id not found" if arr.empty?
    User.new(arr.first)
  end

  def initialize(options)
    @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
  end

  def self.find_by_name(fname, lname)
    arr = QuestionDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND
        lname = ?
    SQL
    arr.map { |h| User.new(h) }
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    QuestionDatabase.instance.execute(<<-SQL, @id).first.values.first
      SELECT
        COUNT(question_likes.id) / CAST(COUNT(DISTINCT questions.id) AS FLOAT)
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_id
      WHERE
        author_id = ?
    SQL
  end

  def save
    if @id.nil?
      QuestionDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL
      @id = QuestionDatabase.instance.last_insert_row_id
    else
      QuestionDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
        UPDATE
          users
        SET
          fname = ?,
          lname = ?
        WHERE
          id = ?
      SQL
    end
  end
end

class Question
  attr_accessor :title, :body, :author_id
  attr_reader :id

  def self.find_by_id(id)
    arr = QuestionDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    raise "id not found" if arr.empty?
    Question.new(arr.first)
  end

  def initialize(options)
    @id, @title, @body, @author_id = options.values_at('id', 'title', 'body', 'author_id')
  end

  def self.find_by_author_id(author_id)
    arr = QuestionDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL
    arr.map { |h| Question.new(h) }
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def save
    if @id.nil?
      QuestionDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
        INSERT INTO
          questions (title, body, author_id)
        VALUES
          (?, ?, ?)
      SQL
      @id = QuestionDatabase.instance.last_insert_row_id
    else
      QuestionDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
        UPDATE
          questions
        SET
          title = ?,
          body = ?,
          author_id = ?
        WHERE
          id = ?
      SQL
    end
  end
end

class QuestionFollow
  attr_accessor :question_id, :user_id
  attr_reader :id

  def self.find_by_id(id)
    arr = QuestionDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL
    raise "id not found" if arr.empty?
    QuestionFollow.new(arr.first)
  end

  def initialize(options)
    @id, @question_id, @user_id = options.values_at('id', 'question_id', 'user_id')
  end

  def self.followers_for_question_id(question_id)
    arr = QuestionDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, fname, lname
      FROM
        question_follows
      JOIN
        users ON user_id = users.id
      WHERE
        question_id = ?
    SQL
    arr.map { |h| User.new(h) }
  end

  def self.followed_questions_for_user_id(user_id)
    arr = QuestionDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, title, body, author_id
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        user_id = ?
    SQL
    arr.map { |h| Question.new(h) }
  end

  def self.most_followed_questions(n)
    arr = QuestionDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, title, body, author_id
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
    arr.map { |h| Question.new(h) }
  end
end

class Reply
  attr_accessor :question_id, :parent, :user_id, :body
  attr_reader :id

  def self.find_by_id(id)
    arr = QuestionDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    raise "id not found" if arr.empty?
    Reply.new(arr.first)
  end

  def initialize(options)
    @id, @question_id, @parent, @user_id, @body = options.values_at('id', 'question_id', 'parent', 'user_id', 'body')
  end

  def self.find_by_user_id(user_id)
    arr = QuestionDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    arr.map { |h| Reply.new(h) }
  end

  def self.find_by_question_id(question_id)
    arr = QuestionDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    arr.map { |h| Reply.new(h) }
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent)
  end

  def child_replies
    arr = QuestionDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent = ?
    SQL
    arr.map { |h| Reply.new(h) }
  end

  def save
    if @id.nil?
      QuestionDatabase.instance.execute(<<-SQL, @question_id, @parent, @user_id, @body)
        INSERT INTO
          replies (question_id, parent, user_id, body)
        VALUES
          (?, ?, ?, ?)
      SQL
      @id = QuestionDatabase.instance.last_insert_row_id
    else
      QuestionDatabase.instance.execute(<<-SQL, @question_id, @parent, @user_id, @body, @id)
        UPDATE
          replies
        SET
          question_id = ?,
          parent = ?,
          user_id = ?,
          body = ?
        WHERE
          id = ?
      SQL
    end
  end
end

class QuestionLike
  attr_accessor :question_id, :user_id
  attr_reader :id

  def self.find_by_id(id)
    arr = QuestionDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL
    raise "id not found" if arr.empty?
    QuestionFollow.new(arr.first)
  end

  def initialize(options)
    @id, @question_id, @user_id = options.values_at('id', 'question_id', 'user_id')
  end

  def self.likers_for_question_id(question_id)
    arr = QuestionDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, fname, lname
      FROM
        question_likes
      JOIN
        users ON user_id = users.id
      WHERE
        question_id = ?
    SQL
    arr.map { |h| User.new(h) }
  end

  def self.num_likes_for_question_id(question_id)
    QuestionDatabase.instance.execute(<<-SQL, question_id).first.values.first
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL
  end

  def self.liked_questions_for_user_id(user_id)
    arr = QuestionDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, title, body, author_id
      FROM
        question_likes
      JOIN
        questions ON question_id = questions.id
      WHERE
        user_id = ?
    SQL
    arr.map { |h| Question.new(h) }
  end

  def self.most_liked_questions(n)
    arr = QuestionDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, title, body, author_id
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
    arr.map { |h| Question.new(h) }
  end
end