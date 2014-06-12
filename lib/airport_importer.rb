class AirportImporter
  class << self
    def run! limit=nil
      failures      = {}
      success_count = 0
      total_count   = 0

      begin
        CSV.foreach(Rails.root.join('db', 'data', 'utahairports.csv')) do |row|
          break if limit && total_count >= limit

          total_count += 1

          airport = Airport.where(faa_code: row[1]).first_or_initialize

          airport.airport_name  = row[2]
          airport.city          = row[0]
          airport.state         = row[3]


          begin
            airport.save!

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