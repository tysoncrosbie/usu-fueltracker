class UtahTap < Report
  def to_csv
    CSV.generate do |csv|
      csv << ['Schedule Type', 'Product Type', 'Purchase Date', 'Invoice Number', 'Manifest Number', 'Point of Origin State', 'Point of Destination State', 'Facility Number', 'Airport Code', "Supplier's Name", "Tax Paid Gallons"]

      utah_airports = Airport.utah_airports
      report = self
      receipts = Receipt.where(airport_id: utah_airports).in_report(report.starts_on, report.ends_on).order(:receipt_date)

      %w(1A 1J).each do |code|
        receipts.each do |receipt|
          csv << [code, '130', receipt.receipt_date, receipt.receipt_number, nil, nil, nil, nil, receipt.airport.faa_code, receipt.vendor_name, receipt.gallons.to_f.round(2)]
        end
      end
    end
  end

end