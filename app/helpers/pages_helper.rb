module PagesHelper
  def extract_title(content)
    content.lines.first.strip.split(":").first
  end
  def extract_dimensions(content)
    dimension_line = content.lines[1].strip
    rows, cols = dimension_line.split.map(&:to_i)
    { rows: rows, cols: cols }
  end
  def extract_matrix(content)
    matrix_lines = content.lines[2..-1]
    matrix = matrix_lines.map { |line| line.strip.chars }
    matrix
  end

  def is_matrix_valid?(content, rows, columns)
    v = false
    matrix_lines = content.lines[2..-1]
    matrix = matrix_lines.map { |line| line.strip.chars }
    if matrix.length == rows && matrix[0].length == columns
      v = true
    end
    v
  end
end
