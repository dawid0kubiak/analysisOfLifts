class Lift < ApplicationRecord
  require 'csv'

  belongs_to :lift_type

  def self.import(file)
    CSV.foreach(file.path, encoding: 'windows-1250:utf-8').with_index do |row, index|
      next if index == 0
      # type = LiftType.where('condition like ?', row[8]).or(LiftType.where('condition like ?', row[9])).first
      # typ_id = type ? type.id : 1
      lift = Lift.find_or_create_by(id_lift: row[0].to_i)
      lift.update(
          date_of_booking: row[1],
          date_of_commissioned: row[2],
          transaction_type: row[3],
          amount: row[4],
          currency: row[5],
          balance: row[6],
          account: row[7],
          name: row[8],
          description: row[9],
          addtional_data: row[10],
          lift_type_id: -1
      )
    end
    self.set_type
  end

    def self.set_type
    LiftType.all.each do |typ|
      next unless typ.condition
     lifts = Lift.where(typ.condition)
      lifts.update(lift_type_id: typ.id)
      puts
    end
  end

end
