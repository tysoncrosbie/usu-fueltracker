class UsuEnvironmental < Report

  def to_csv
    airports = Airport.all

    CSV.generate do |csv|
      months = (self.starts_on..self.ends_on).collect {|d| d.strftime('%Y - %B')}.uniq
      csv << ['Plane Tail Number'] + months.collect {|m| [m,'']}.flatten
      csv << [''] + months.collect {|m| ['Gallons', 'Fuel Cost']}.flatten + ['Total Yearly Gallons', 'Total Yearly Cost']

      Plane.all.group_by(&:fuel_type).each do |fuel_type, planes|

        planes.each do |plane|
          totals = plane.receipts.where(airport_id: airports).in_report(self.starts_on, self.ends_on).select("DATE_PART('month', receipts.receipt_date) as month, SUM(receipts.gallons) as gallons_total, SUM(receipts.fuel_cost) as fuel_cost_total").group('month')

          default_totals = {}
          (self.starts_on..self.ends_on).collect {|d| d.month }.uniq.each do |month|
            default_totals[month] = [0.0,0.0]
          end

          totals.each do |t|
            default_totals[t.month.to_i] = [t.gallons_total.to_f, t.fuel_cost_total.to_f]
          end

          csv << ["#{plane.tail_number} - #{plane.plane_type}"] + default_totals.values.flatten + [default_totals.values.sum(&:first).to_f.round(2), default_totals.values.sum(&:last).to_f.round(2)]
        end


        subtotals = Receipt.where(airport_id: airports).where(plane_id: planes).in_report(self.starts_on, self.ends_on).select("DATE_PART('month', receipts.receipt_date) as month, SUM(receipts.gallons) as gallons_total, SUM(receipts.fuel_cost) as fuel_cost_total").group('month')

        default_totals = {}
        (self.starts_on..self.ends_on).collect {|d| d.month }.uniq.each do |month|
          default_totals[month] = [0.0,0.0]
        end

        subtotals.each do |t|
          default_totals[t.month.to_i] = [t.gallons_total.to_f, t.fuel_cost_total.to_f]
        end

        csv << ["#{fuel_type.upcase} SUBTOTAL"] + default_totals.values.flatten + [default_totals.values.sum(&:first).to_f.round(2), default_totals.values.sum(&:last).to_f.round(2)]

      end

      yearly_totals = Receipt.where(airport_id: airports).in_report(self.starts_on, self.ends_on).select("DATE_PART('month', receipts.receipt_date) as month, SUM(receipts.gallons) as gallons_total, SUM(receipts.fuel_cost) as fuel_cost_total").group('month')

      default_totals = {}
      (self.starts_on..self.ends_on).collect {|d| d.month }.uniq.each do |month|
        default_totals[month] = [0.0,0.0]
      end

      yearly_totals.each do |t|
        default_totals[t.month.to_i] = [t.gallons_total.to_f, t.fuel_cost_total.to_f]
      end

        csv << ['TOTALS'] + default_totals.values.flatten + [default_totals.values.sum(&:first).to_f.round(2), default_totals.values.sum(&:last).to_f.round(2)]

    end
  end

end
