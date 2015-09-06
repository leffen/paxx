module Paxx

  class NameNormalizer
    attr_reader :name, :first_name, :last_name, :full_name

    def initialize src_name
      @name = src_name
      @first_name, @last_name = splitt
    end

    def valid
      !(name.to_s.strip.length == 0)
    end

    def normalize(txt=name)
      txt.to_s.gsub("\n", ' ').squeeze(' ').strip
    end


    def subst_norwegian_chars(txt)
      [["æ", "ae"], ["ø", "oe"], ["å", "aa"]].each do |int|
        txt = txt.gsub(int[0], int[1])
      end
      [["Æ", "AE"], ["Ø", "OE"], ["Å", "AA"]].each do |int|
        txt = txt.gsub(int[0], int[1])
      end
      txt
    end

    def camelize(txt=name)
      txt.split(/[^a-zøæåØÆÅ0-9]/i).map { |w| w.capitalize }.join if txt
    end

    def splitt
      words = name.to_s.split()
      if words.count > 1
        last_name = words.last
        words.pop
        first_name = words.join(" ")
      else
        first_name = name
        last_name=""
      end
      [camelize(first_name), camelize(last_name)]
    end

    def as_id(txt=name)
      subst_norwegian_chars(txt.delete(" ").delete("-")).downcase if txt
    end

    def compose_short_ref first,last
      "#{first}#{last}"
    end

    def last_part name,counter
      if name && counter < name.length
        name[0..counter]
      else
        "#{name}#{counter-name.length+1}"
      end
    end

    def as_short_ref
      counter = 0
      unique = !block_given?
      xref =  ""
      start = camelize(as_id(first_name))

      begin
        shortref = compose_short_ref start,xref

        if !unique
          unique = yield shortref
          if !unique
            counter += 1
            xref =  last_part(camelize(as_id(last_name)),counter)
          end
        end
      end while !unique  && counter < 100
      shortref
    end


  end

end