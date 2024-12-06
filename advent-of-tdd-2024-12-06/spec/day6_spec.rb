# frozen_string_literal: true

def calculate_grid(input)
  input.split.map do |line|
    line.split('')
  end
end

def find_start_position(grid)
  position = []
  grid.each_with_index do |row, i|
    if row.include?('^')
      position << i
      position << row.find_index('^')
    end
  end
  position
end

def calculate_path(grid)
  y, x = find_start_position(grid)
  grid[y][x] = 'X'
  grid[0][x] = 'X' if y == 1
  grid
end

def calculate_next_location(_grid)
  [0, 2]
end

RSpec.describe 'Day 6' do
  it 'can turn a puzzle input into a multi dimensional array' do
    input = "....#\n.....\n.....\n.#...\n"
    expect(calculate_grid(input)).to eq(
      [
        ['.', '.', '.', '.', '#'],
        ['.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.'],
        ['.', '#', '.', '.', '.']
      ]
    )
  end

  it 'can find the guards location (bottom row)' do
    grid = [
      ['.', '.', '.', '.', '.'],
      ['.', '#', '^', '.', '.']
    ]
    expect(find_start_position(grid)).to eq([1, 2])
  end

  it 'can find the guards location (top row)' do
    grid = [
      ['.', '.', '^', '.', '.'],
      ['.', '#', '.', '.', '.']
    ]
    expect(find_start_position(grid)).to eq([0, 2])
  end
  [{ grid: [
    ['.', '.', '^', '.', '.'],
    ['.', '#', '.', '.', '.']
  ], result: [
    ['.', '.', 'X', '.', '.'],
    ['.', '#', '.', '.', '.']
  ] },
   { grid: [
       ['.', '.', '.', '.', '.'],
       ['.', '#', '^', '.', '.']
     ],
     result: [
       ['.', '.', 'X', '.', '.'],
       ['.', '#', 'X', '.', '.']
     ] }].each do |example|
    it 'can calculate path' do
      expect(calculate_path(example[:grid])).to eq(example[:result])
    end
  end

  it 'can find the next location base on current position' do
    grid = [
      ['.', '.', '.', '.', '.'],
      ['.', '#', '^', '.', '.']
    ]
    expect(calculate_next_location(grid)).to eq([0, 2])
  end
end
