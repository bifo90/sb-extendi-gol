class Game < ApplicationRecord
  belongs_to :user

  validates_presence_of :rows, :columns, :matrix

  validate :check_matrix_format


  def check_matrix_format
    if parsed_matrix.length != rows
      errors.add(:matrix, "Invalid rows")
    end
    parsed_matrix.each do |row|
      if row.length != columns or (row.index(".").nil? && row.index("*").nil?)
        errors.add(:matrix, "Invalid Columns")
      end
    end
  end

  def parsed_matrix
    JSON.parse(matrix)
  end

  def next_generation
    new_matrix = parsed_matrix
    new_matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        current_cell_state = parsed_matrix[i][j]
          if new_matrix[i][j] == "*" && (calculate_neighbours(i, j) < 2 || calculate_neighbours(i, j) > 3)
            new_matrix[i][j] = "."
          elsif new_matrix[i][j] == "." && (calculate_neighbours(i, j) == 3)
            new_matrix[i][j] = "*"
          else
            new_matrix[i][j] = current_cell_state
          end
      end
    end
    new_matrix
  end

  private
  def calculate_neighbours(x, y)
    sum = 0
    (-1..1).each do |i|
      (-1..1).each do |j|
        # Se ho 4 righe, x sarà compreso tra 0 e 3.
        # Mi trovo sulla coordinata x (riga) == 0, quindi x = 0, cerco i vicini (che in questo caso equivale a x = 3, cioè l'elemento opposto, per
        # calcolarlo prendo x = 0, i = -1 (cerco tra la riga sopra la mia), ci aggiungo 4, la somma è pari a 3; 3 % 4 è uguale a 3). Facendo questo
        # per le righe e le colonne, posso calcolare i miei vicini in posizione opposta
        row = (x + i + rows) % rows
        col = (y + j + columns) % columns
        sum += value(parsed_matrix[row][col])
      end
    end
    # Tolgo il valore di se stesso dalla somma
    sum -= value(parsed_matrix[x][y])
    sum
  end

  def value(symbol)
    val = 0
    if symbol == "*"
      val = 1
    end
    val
  end
end
