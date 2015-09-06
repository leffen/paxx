module Paxx
  class DateParser

    def decode(src)
      return src if src.is_a?(Time)
      return nil unless src && src.rstrip.length > 7

      len = src.to_s.strip.length
      parsed_date = nil
      begin
        parsed_date = decode_6digits_date(src) if len == 8 ||  len == 10
        parsed_date = DateTime.parse(src) if !parsed_date
      rescue => e
        puts "Exception Paxx::DateParser>#{src} e=#{e}"
        parsed_date = Chronic.parse(src)
      end
      parsed_date
    end


    def adjust_year(year)
      if year < 100 && year <= (Time.now.year-2000)
        year + 2000
      elsif year < 100 && year > (Time.now.year-2000)
        year + 1900
      else
        year
      end

    end


    # dd.mm.yy
    def decode_6digits_date dt
      day   = dt[0, 2].to_i
      month = dt[3, 2].to_i
      year  = adjust_year(dt[6, 4].to_i)

      Time.local(year, month, day)
    end

    def calc_age(dob)
      return nil unless  dob
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end

  end



end
