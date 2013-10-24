class Product 
  attr_accessor(:quantity, :name, :price)

  def initialize(quantity, name, price)
    @quantity = quantity
    @name = name
    @price = price
  end

  def tax_rate
    0.10
  end

  def subtotal
    quantity * @price 
  end

  def sales_tax        
    subtotal * tax_rate
  end

  def total_price
    subtotal + sales_tax
  end
end

class Exempt < Product
  def tax_rate
    0
  end
end

class Imported  < Product
  def tax_rate
    super + 0.05  
  end
end

class ImportedExempt < Exempt
  def tax_rate
     super + 0.05
  end
end

class Receipt
  attr_accessor :products

  def initialize(*products)
     @products = products
  end

  def salestax_cal
    sales_tax_total = 0
    @products.each do |p|    
      sales_tax_total += p.sales_tax 
    end
    return sales_tax_total
  end

  def total
    total = 0
    @products.each do |p|
      total += p.total_price
    end
    return total
  end

  def print_totals
    @products.each do |p| 
      puts "#{p.quantity} #{p.name} : $#{p.price}"
    end
    puts "------------------------------------------\n"
    puts "Sales Taxes: $#{sprintf('%.2f', salestax_cal)}"
    puts "------------------------------------------\n"
    puts "Total: $#{sprintf('%.2f', total)}"
  end
end

cd = Product.new(1, "CD", 14.99)
perf = Product.new(1, "Perfume", 20.89)

book = Exempt.new(1, "Book", 12.49)
choco = Exempt.new(1, "Chocolate Bar", 0.85)
pills = Exempt.new(1, "Headache Pills", 9.75)

imported_chocolates = ImportedExempt.new(1, "Imported Chocolate", 10.50)
imported_perfume = Imported.new(1, "Imported Perfume", 54.65)

order1 = Receipt.new(book, cd, choco)
order2 = Receipt.new(imported_chocolates, imported_perfume)
order3 = Receipt.new(imported_perfume, perf, pills, imported_chocolates)

puts "\n"
puts "Order 1"
puts "====================\n\n"
puts order1.print_totals
puts "Order 2"
puts "====================\n\n"
puts order2.print_totals
puts "Order 3"
puts "====================\n\n"
puts order3.print_totals