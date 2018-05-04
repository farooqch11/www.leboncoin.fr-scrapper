class Crawl < ApplicationRecord

  def self.get_proxies
    proxies = []
    File.open('proxy.txt', "r").each_line do |line|
      # tokens = line.split(":")
      # proxy = { ip: tokens[0], port: tokens[1].delete("\n") }
      proxies << line
    end
    return proxies
  end
  require 'selenium-webdriver'
  require 'nokogiri'
  require 'capybara'

  module ::Selenium::WebDriver::Remote
    class Bridge
      alias_method :old_execute, :execute
      def execute(*args)
        sleep(3)
        old_execute(*args)
      end
    end
  end

  def self.test

    proxies = get_proxies

    # require 'selenium-webdriver'
    # require 'nokogiri'
    # require 'capybara'
    # Configurations

    begin
      # proxy = proxies[0]

      Capybara.register_driver :firefox do |app|
        profile = Selenium::WebDriver::Firefox::Profile.new

        # profile['browser.cache.disk.enable']    = false
        # profile['browser.cache.memory.enable']  = false
        # profile['browser.cache.offline.enable'] = false
        # profile['network.http.use-cache']       = false
        # profile['args']       = '--headless'
        profile['permissions.default.image']       = 2
        profile['general.useragent.override'] = "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) AppleWebKit/418.9 (KHTML, like Gecko) Hana/1.1"
        # proxyx = Selenium::WebDriver::Proxy.new(http: "199.247.13.177:31280")
        # profile.proxy = proxyx
        profile.proxy = Selenium::WebDriver::Proxy.new http: '199.247.13.177:31280', ssl: '199.247.13.177:31280'
        options = Selenium::WebDriver::Firefox::Options.new(profile: profile)
        options.args << '--headless'
        Capybara::Selenium::Driver.new :firefox, options: options
      end


      Capybara.javascript_driver = :firefox

      Capybara.configure do |config|
        config.default_max_wait_time = 200 # seconds
        config.default_driver = :firefox
      end

      # Visit
      browser = Capybara.current_session
      driver = browser.driver.browser

      (20..20.to_i).each do |i|
        url = "https://www.leboncoin.fr/prestations_de_services/offres/?o=#{i}&q=site%20internet&it=1"

        # puts "[#{i}]Visit " << url << " as " << proxy[:ip] << ":" << proxy[:port]

        page = browser.visit url

        main_page = Nokogiri::HTML(driver.page_source)

        urls = main_page.xpath("//section[@class='tabsContent block-white dontSwitch']/ul/li/a[@class='list_item clearfix trackable']/@href");
        # puts urls.map(&:text)

        urls.map(&:text).each_with_index do |page_url, index|
          puts page_url[2..-1], "***Crawling #{index} ***"
          # page_url[2..-1]
          # puts page_url, "***trying***"
          begin
            # try = 0;
            # Capybara.register_driver :firefox do |app|
            #   profile = Selenium::WebDriver::Firefox::Profile.new
            #
            #   # profile['browser.cache.disk.enable']    = false
            #   # profile['browser.cache.memory.enable']  = false
            #   # profile['browser.cache.offline.enable'] = false
            #   # profile['network.http.use-cache']       = false
            #   # profile['args']       = '--headless'
            #   profile['permissions.default.image']       = 2
            #   profile['general.useragent.override'] = proxies[index]
            #   # proxyx = Selenium::WebDriver::Proxy.new(http: "199.247.13.177:31280")
            #   # profile.proxy = proxyx
            #   profile.proxy = Selenium::WebDriver::Proxy.new http: '199.247.13.177:31280', ssl: '199.247.13.177:31280'
            #   options = Selenium::WebDriver::Firefox::Options.new(profile: profile)
            #   options.args << '--headless'
            #   Capybara::Selenium::Driver.new :firefox, options: options
            # end
            #
            #
            # Capybara.javascript_driver = :firefox
            #
            # Capybara.configure do |config|
            #   config.default_max_wait_time = 200 # seconds
            #   config.default_driver = :firefox
            # end
            #
            # # Visit
            # browser = Capybara.current_session
            # driver = browser.driver.browser

            browser.visit "https://#{page_url[2..-1]}"



            # loop do
            #   if driver.execute_script('return document.readyState') == "complete"
            #     break
            #   end
            # end

            browser.click_button('Voir le numéro')

            loop do
              sleep(5)
              if driver.execute_script('return document.readyState') == "complete"
                break
              end
            end

            detail_page = Nokogiri::HTML(driver.page_source)

            phone_number = detail_page.xpath('/html/body/div/div/div/span[1]/section/main/div/div/div/section/section[2]/section[2]/div[1]/div/div/div/div[2]/div[1]/div/div/div/span/a').text;
            title = detail_page.xpath('/html/body/div/div/div/span[1]/section/main/div/div/div/section/section[2]/section[1]/div[1]/div[2]/div[1]/div[1]/h1').text;
            # name = detail_page.xpath('/html/body/div/div/div/span[1]/section/main/div/div/div/section/section[2]/section[1]/div[1]/div[2]/div[1]/div[1]/h1').text;
            puts phone_number , title



            # CSV.open("data.csv", "w") do |csv|
            #   csv << [phone_number.to_s, title.to_s]
            # end


            #
            if (index !=0) && (index%2 == 0)
              # puts "record # #{index} , sleeping for 20 seconds"
              sleep(20)
            end

          rescue
            puts "retrying with new proxy for detail page phone number"
            # proxies.delete_if { |hash| hash[:ip] == proxy[:ip] && hash[:port] == proxy[:port] }
            # try++
            # if try == 5
            #   raise
            # else
            #   retry
            # end
            raise
          end


        end
      end

    rescue Exception
      raise
    end

  end


end
