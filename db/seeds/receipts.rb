puts
puts 'Seeding Receipts'

limit = 20

ReceiptImporter.run! limit
