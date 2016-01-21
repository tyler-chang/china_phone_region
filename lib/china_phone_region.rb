class ChinaPhoneRegion
    require 'json'
    @@ac_map = JSON.parse(File.read(File.expand_path('../../data/area_codes_map.json', __FILE__), mode: 'r'))

    def self.area_code(code)
        address = @@ac_map['ac' + code]
        "#{address['province']}#{address['citys'][0]}" unless address.nil?
    end
end
