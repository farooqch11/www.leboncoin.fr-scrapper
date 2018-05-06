class Scrap < ApplicationRecord

  # require 'selenium-webdriver'
  # require 'nokogiri'
  # require 'capybara'
  #
  # module ::Selenium::WebDriver::Remote
  #   class Bridge
  #     alias_method :old_execute, :execute
  #     def execute(*args)
  #       sleep(2)
  #       old_execute(*args)
  #     end
  #   end
  # end
  #
  # def self.start(star_page,end_page)
  #
  #   begin
  #     Capybara.register_driver :firefox do |app|
  #       profile = Selenium::WebDriver::Firefox::Profile.new
  #       profile['permissions.default.image']       = 2
  #       profile['general.useragent.override'] = "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) AppleWebKit/418.9 (KHTML, like Gecko) Hana/1.1"
  #       profile.proxy = Selenium::WebDriver::Proxy.new http: '199.247.13.177:31280', ssl: '199.247.13.177:31280'
  #       options = Selenium::WebDriver::Firefox::Options.new(profile: profile)
  #       options.args << '--headless'
  #       Capybara::Selenium::Driver.new :firefox, options: options
  #     end
  #
  #     Capybara.javascript_driver = :firefox
  #     Capybara.configure do |config|
  #       config.default_max_wait_time = 200 # seconds
  #       config.default_driver = :firefox
  #     end
  #
  #     # Visit
  #     browser = Capybara.current_session
  #     driver = browser.driver.browser
  #
  #     (star_page.to_i..end_page.to_i).each do |i|
  #       url = "https://www.leboncoin.fr/prestations_de_services/offres/?o=#{i}&q=site%20internet&it=1"
  #
  #       page = browser.visit url
  #
  #       Link.create(url: url,page_number: i)
  #
  #       main_page = Nokogiri::HTML(driver.page_source)
  #
  #       urls = main_page.xpath("//section[@class='tabsContent block-white dontSwitch']/ul/li/a[@class='list_item clearfix trackable']/@href");
  #
  #
  #       urls.map(&:text).each_with_index do |page_url, index|
  #         puts page_url[2..-1], "***Crawling #{index} ***"
  #
  #         begin
  #
  #           browser.visit "https://#{page_url[2..-1]}"
  #
  #           browser.click_button('Voir le numéro')
  #
  #           loop do
  #             sleep(5)
  #             if driver.execute_script('return document.readyState') == "complete"
  #               break
  #             end
  #           end
  #
  #           detail_page = Nokogiri::HTML(driver.page_source)
  #
  #           phone_number = detail_page.xpath('/html/body/div/div/div/span[1]/section/main/div/div/div/section/section[2]/section[2]/div[1]/div/div/div/div[2]/div[1]/div/div/div/span/a').text;
  #           title = detail_page.xpath('/html/body/div/div/div/span[1]/section/main/div/div/div/section/section[2]/section[1]/div[1]/div[2]/div[1]/div[1]/h1').text;
  #           name = detail_page.xpath('/html/body/div/div/div/span[1]/section/main/div/div/div/section/section[2]/section[2]/div[1]/div/div/div/div[1]/div[2]/div[1]').text;
  #           city = detail_page.xpath('/html/body/div/div/div/span[1]/section/main/div/div/div/section/section[2]/section[1]/div[4]/div[2]/div/div/div[2]/span').text;
  #           puts phone_number , title, name , city
  #
  #           User.create(name: name,title: title,phone: phone_number,city: city)
  #
  #
  #
  #           #
  #           if (index !=0) && (index%2 == 0)
  #             # puts "record # #{index} , sleeping for 20 seconds"
  #             sleep(5)
  #           end
  #
  #         rescue
  #           puts "retrying with new proxy for detail page phone number"
  #
  #           next
  #         end
  #
  #       end
  #     end
  #
  #   rescue Exception
  #     raise
  #   end
  # end

end
