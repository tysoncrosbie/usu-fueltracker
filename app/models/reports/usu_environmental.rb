class UsuEnvironmental < Report

  def to_csv
    CSV.generate do |csv|

      utah_airports = Airport.utah_airports
      report = self
      receipts = Receipt.where(airport_id: utah_airports).in_report(report.starts_on, report.ends_on)

      receipt_months = receipts.group_by { |r| r.receipt_date.beginning_of_month }


      receipt_months.keys.sort.each do |month|
        csv << ["#{month.strftime(' %Y - %B')}"]
        csv << [nil, "Aircraft", 'Fuel Gallons', 'Fuel Cost']

        for receipt in receipt_months[month]
          csv << [nil, "#{receipt.plane.tail_number} - #{receipt.plane.plane_type}", receipt.gallons, receipt.fuel_cost]
          csv << ["MONTH TOTAL", nil,
            receipt_months.map{ |m, r| r.map{ |g| g.gallons.to_i}.reduce}.reduce(0, :+),
            receipt_months.map{ |m, r| r.map{ |f| f.fuel_cost.to_i}.reduce}.reduce(0, :+)
          ]
          csv << ['']
        end
      end

      csv << ["YEARLY TOTALS", nil, receipts.map{ |r| r.gallons.to_i }.reduce(0, :+), receipts.map{ |r| r.fuel_cost.to_i }.reduce(0, :+)]

    end
  end

end