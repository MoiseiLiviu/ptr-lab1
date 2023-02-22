defmodule OneTest do
  use ExUnit.Case

  test "greets the world" do
    assert One.hello() == "Hello, PTR!"
  end

  test "is_prime? returns true for primes" do
    assert One.is_prime?(2)
    assert One.is_prime?(3)
    assert One.is_prime?(5)
    assert One.is_prime?(7)
    assert One.is_prime?(11)
    assert One.is_prime?(13)
  end

  test "is_prime? returns false for non-primes" do
    refute One.is_prime?(1)
    refute One.is_prime?(4)
    refute One.is_prime?(6)
    refute One.is_prime?(8)
    refute One.is_prime?(9)
    refute One.is_prime?(10)
  end

  test "cylinder_area returns the correct area" do
    assert One.cylinder_area(4, 3) == 131.94689145077132
    assert One.cylinder_area(5, 2) == 87.96459430051421
  end

  test "reverse_list returns the list in reverse order" do
    assert One.reverse_list([1, 2, 3]) == [3, 2, 1]
    assert One.reverse_list([4, 5, 6, 7]) == [7, 6, 5, 4]
  end

  test "unique_sum returns the correct sum of unique elements" do
    assert One.unique_sum([1, 2, 3, 3, 4, 4, 5]) == 15
    assert One.unique_sum([1, 1, 2, 2, 3, 3]) == 6
    assert One.unique_sum([1, 1, 1]) == 1
  end

  test "extract_random_list returns a list of the specified length" do
    list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    random_list = One.extract_random_list(list, 5)
    assert length(random_list) == 5
  end

  test "extract_random_list returns a random subset of the list" do
    list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    random_list1 = One.extract_random_list(list, 5)
    random_list2 = One.extract_random_list(list, 5)
    refute random_list1 == random_list2
  end

  test "first_fibonacci returns the first n Fibonacci numbers" do
    assert One.first_fibonacci(1) == [1]
    assert One.first_fibonacci(2) == [1, 1]
    assert One.first_fibonacci(3) == [1, 1, 2]
    assert One.first_fibonacci(4) == [1, 1, 2, 3]
    assert One.first_fibonacci(5) == [1, 1, 2, 3, 5]
  end

  test "translate replaces words with their translation from a dictionary" do
    dict = %{"hello" => "hola", "world" => "mundo"}
    assert One.translate(dict, ["hello", "world"]) == ["hola", "mundo"]
  end
end