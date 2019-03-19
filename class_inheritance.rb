class Employee
  attr_reader :salary
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @bonus = self.salary * multiplier
  end



end

class Manager < Employee
  attr_reader :employees, :salary

  def initialize(name, title, salary, boss, employees)
    
    @employees = employees
    super(name, title, salary, boss)
  end

  def bonus(multiplier)
    total_sal = 0
    queue = self.employees.dup
    while !queue.empty?
      e = queue.shift
      if e.is_a?(Manager)
        queue += e.employees
      end
      total_sal += e.salary 
    end

    total_sal * multiplier
  end



end