class UsuEnvironmental < Report

  def to_csv
    utah_airports = Airport.utah_airports

    CSV.generate do |csv|
      months = (self.starts_on..self.ends_on).collect {|d| d.strftime('%Y - %B')}.uniq
      csv << [''] + months.collect {|m| [m,'']}.flatten
      csv << ['Plane'] + months.collect {|m| ['Gallons', 'Fuel Cost']}.flatten + ['Total Gallons', 'Total Cost']

      Plane.all.group_by(&:fuel_type).each do |fuel_type, planes|

        planes.each do |plane|
          totals = plane.receipts.where(airport_id: utah_airports).in_report(self.starts_on, self.ends_on).select("DATE_PART('month', receipts.receipt_date) as month, SUM(receipts.gallons) as gallons_total, SUM(receipts.fuel_cost) as fuel_cost_total").group('month')

          default_totals = {}
          (self.starts_on..self.ends_on).collect {|d| d.month }.uniq.each do |month|
            default_totals[month] = [0.0,0.0]
          end

          totals.each do |t|
            default_totals[t.month.to_i] = [t.gallons_total.to_f, t.fuel_cost_total.to_f]
          end

          csv << ["#{plane.tail_number} - #{plane.plane_type}"] + default_totals.values.flatten + [default_totals.values.sum(&:first).to_f, default_totals.values.sum(&:last).to_f]
        end


        subtotals = Receipt.where(airport_id: utah_airports).where(plane_id: planes).in_report(self.starts_on, self.ends_on).select("DATE_PART('month', receipts.receipt_date) as month, SUM(receipts.gallons) as gallons_total, SUM(receipts.fuel_cost) as fuel_cost_total").group('month')

        default_totals = {}
        (self.starts_on..self.ends_on).collect {|d| d.month }.uniq.each do |month|
          default_totals[month] = [0.0,0.0]
        end

        subtotals.each do |t|
          default_totals[t.month.to_i] = [t.gallons_total.to_f, t.fuel_cost_total.to_f]
        end

        csv << ["#{fuel_type} SUBTOTAL"] + default_totals.values.flatten + [default_totals.values.sum(&:first).to_f, default_totals.values.sum(&:last).to_f]

      end

      yearly_totals = Receipt.where(airport_id: utah_airports).in_report(self.starts_on, self.ends_on).select("DATE_PART('month', receipts.receipt_date) as month, SUM(receipts.gallons) as gallons_total, SUM(receipts.fuel_cost) as fuel_cost_total").group('month')

      default_totals = {}
      (self.starts_on..self.ends_on).collect {|d| d.month }.uniq.each do |month|
        default_totals[month] = [0.0,0.0]
      end

      yearly_totals.each do |t|
        default_totals[t.month.to_i] = [t.gallons_total.to_f, t.fuel_cost_total.to_f]
      end

        csv << ['TOTALS'] + default_totals.values.flatten + [default_totals.values.sum(&:first).to_f, default_totals.values.sum(&:last).to_f]

    end
  end

end

  # csv << ["YEARLY TOTALS", nil, receipts.sum(&:gallons), receipts.sum(&:fuel_cost)]
