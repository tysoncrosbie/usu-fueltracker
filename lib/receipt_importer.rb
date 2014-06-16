class ReceiptImporter
  class << self
    def run! limit=nil
      failures      = {}
      success_count = 0
      total_count   = 0

      begin
        # rows: id, plane_id, airport_id, reciept_number, receipt_date, vendor_name, gallons, fuel_cost

        CSV.foreach(Rails.root.join('db', 'data', 'receipts.csv')) do |row|
          break if limit && total_count >= limit

          total_count += 1

          receipt = Receipt.where(id: row[0].to_i).first_or_initialize

          receipt.plane_id        = row[1].to_i
          receipt.airport_id      = row[2].to_i
          receipt.receipt_number  = row[3]
          receipt.receipt_date    = row[4].to_date
          receipt.vendor_name     = row[5]
          receipt.gallons         = row[6].to_f
          receipt.fuel_cost       = row[7].to_f


          begin
            receipt.save!

            print "."
            success_count += 1
          rescue => e
            print "F"
            failures[row[1]] = e.message
          end
        end
      rescue => e
        puts "An error occured during processing: #{e.inspect}"
        pp e.backtrace
      ensure
        puts

        if failures.present?
          puts "#{failures.length} failures encountered:"
          failures.each do |k,v|
            puts " - #{k}: #{v}"
          end
        end

        puts
        puts "#{success_count} of #{total_count} imported successfully."
      end
    end
  end
end