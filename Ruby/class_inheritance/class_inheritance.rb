class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss, employees = [])
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    sum_employee_salaries * multiplier
  end

  def sum_employee_salaries
    sum = 0
    @employees.each do |employee|
      sum += employee.salary
      sum += employee.sum_employee_salaries if employee.class == Manager
    end
    sum
  end
end

ned = Manager.new('Ned', 'Founder', 100000, nil)
darren = Manager.new('Darren', 'TA Manager', 78000, ned)
shawna = Employee.new('Shawna', 'TA', 12000, darren)
david = Employee.new('David', 'TA', 10000, darren)

ned.employees = [darren]
darren.employees = [shawna, david]