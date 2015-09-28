Pod::Spec.new do |s|
  s.name         = "WACoreDataSpotlight"
  s.version      = "0.0.4"
  s.summary      = "Automatically index your CoreData objects to CoreSpotlight on iOS 9"

  s.description  = <<-DESC
                  With iOS 9 comes great new features. One of them is CoreSpotlight.
		  WACoreDataSpotlight, after a quick configuration, automatically index you core data database. Yeah, you heard it. Automatically.
	 	 DESC

  s.homepage     = "https://github.com/Wasappli/WACoreDataSpotlight"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "ipodishima" => "marian.paul2@gmail.com" }
  s.social_media_url   = "http://twitter.com/ipodishima"

  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Wasappli/WACoreDataSpotlight.git", :tag => "0.0.4" }
  s.source_files  = "Files/*.{h,m}"
  s.frameworks = "CoreData", "CoreSpotlight"
end
