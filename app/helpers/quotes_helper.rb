module QuotesHelper
  def shuffle what
    update_page do |page|
      if what[:expand][0] == "mac_body"
        page << "document.forms[0].reset()"
        page.replace :photo, :text => '<img alt="' + @computer.name + '" border="0" id="photo" name="photo" src="/images/' + @computer.image_name + '.jpg" width="320">'
        page.replace "quote_processor_id", collection_select(:quote, :processor_id, @computer.processors, :id, :name, {:prompt => "Processor Speed"},{:class => "box", :classname => "box"})
        page.replace "quote_disk_id", collection_select( :quote, :disk_id, @computer.disks, :id, :name, { :prompt => "Hard Disk size"},{ :class => "box", :classname => "box"})
        page.replace "quote_ram_id", collection_select(:quote, :ram_id, @computer.rams, :id, :name, {:prompt => "Ram installed"}, {:class => "box", :classname => "box" })
        page.replace_html :computer_name, :text => @computer.name
      end
      for dom in what[:expand]
        page.visual_effect(:blind_down, dom)
      end if what[:expand]
      for dom in what[:contract]
        page.visual_effect(:blind_up, dom)
      end if what[:contract]
    end
  end
  def toggle_macbox
    update_page do |page|
      page << 'if (value == 1) {'
      page.show "macboxyes"
      page.hide "macboxno"
      page << '} else {'
      page.hide "macboxyes"
      page.show "macboxno"
      page << '}'
    end
  end
  def terms_and_conditions
    update_page do |page|
      page.alert("The t&c<br>hello")
    end
  end
  def date_selector
    today = Time.now - 1.day
    result = []
    for index in 1..14
      today += 1.day
      while today.wday == 0 or today.wday == 6
        today += 1.day
      end
      result << ["#{today.strftime("%A")} #{today.mday} #{today.strftime("%b")} #{today.year}", today]
    end
    select(@quote, :collection_date, result, {}, :id => "collection-date", :name => "quote[collection_date]")
  end
end
