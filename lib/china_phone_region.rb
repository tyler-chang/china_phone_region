class ChinaPhoneRegion
    require 'json'
    require 'mobinfo'
    @@ac_map = JSON.parse(File.read(File.expand_path('../../data/area_codes_map.json', __FILE__), mode: 'r'))

    def self.query(code)
        area_code = get_area_code(code)
        if !area_code.nil?
            query_area_code(area_code)
        elsif is_phone_number(code)
            mobinfo = query_phone_number(code)
        end
    end

    def self.query_area_code(code)
        temp = @@ac_map['ac' + code]
        { :province => temp['province'], :city => temp['citys'][0], :region_code => code, :isp => '' } unless temp.nil?
    end

    def self.query_phone_number(code)
        temp = MobInfo.lookup(code)
        { :province => temp[:province], :city => temp[:city], :region_code => temp[:region_code], :isp => temp[:isp] } unless temp.nil?
    end

    def self.is_phone_number(code)
        code = code.to_s
        !code.match(/^1\d{10}$/).nil?
    end

    def self.get_area_code(code)
        code = code.to_s
        area_code = code.match(/^(0[1-2]\d)|^(0[3-9]\d{2})/)
        area_code[0] unless area_code.nil?
    end
end
