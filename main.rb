require 'set'  
require 'date'

class Student
  @@students = Set.new
  attr_reader :name, :surname, :birth_date

  def self.students
    @@students
  end

  def initialize(name, surname, birth_date)
    @name = name
    @surname = surname

    raise ArgumentError, "Birth date must be in the past" unless birth_date < Date.today
    @birth_date = birth_date

  end

  def calculate_age
    age = Date.today.year - @birth_date.year
    age -= 1 if Date.today < @birth_date + age * 365.25  
    age
  end

  def add_student
    unless @@students.any? { |s| s.name == name && s.surname == surname && s.birth_date == birth_date }
      @@students << self
    end
  end

  def remove_student
    @@students.delete(self)
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end
end

st1 = Student.new("A", "a", Date.new(2001,2,3))
st2 = Student.new("B", "b", Date.new(2000,4,5))
st3 = Student.new("C", "c", Date.new(2002,3,4))
st4 = Student.new("C", "c", Date.new(2002,3,4))

p Student.students
p st1.calculate_age
p st2.calculate_age
p st3.calculate_age
p st4.calculate_age
st1.add_student
st2.add_student
st3.add_student
st4.add_student
p Student.students
  
p Student.get_students_by_age 23
p Student.get_students_by_name "B"