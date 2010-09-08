module Sevendigital 

  class Track < SevendigitalObject
    attr_accessor :id, :title, :version, :artist
                  
    sevendigital_basic_property :track_number,:duration, :explicit_content, :isrc, :release, :url, :price

    def get_details(options={})
      track_with_details = @api_client.track.get_details(@id, options)
      copy_basic_properties_from(track_with_details)
    end
    
    def short_title
  #   return title.gsub(/\s+[\(\[](album|lp|single|short|edit|radio)\s+version[\)\]]/, "")
      return title.gsub(/\s+\(.*\s(version|mix|remix|edit)\s*\)/, "")
    end

    def similar?(the_other_track)
      return the_other_track && short_title.downcase == the_other_track.short_title.downcase \
            && the_other_track.artist && artist.name.downcase == the_other_track.artist.name.downcase
    end

  end
end