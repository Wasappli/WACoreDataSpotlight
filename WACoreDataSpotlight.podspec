Pod::Spec.new do |s|
  s.name         = "WACoreDataSpotlight"
  s.version      = "0.0.1"
  s.summary      = "A short description of WACoreDataSpotlight."

  s.description  = <<-DESC
                   A longer description of WACoreDataSpotlight in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "http://EXAMPLE/WACoreDataSpotlight"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "ipodishima" => "marian.paul2@gmail.com" }
  s.social_media_url   = "http://twitter.com/ipodishima"

  s.platform     = :ios, "7.0"
  s.source       = { :git => "http://EXAMPLE/WACoreDataSpotlight.git", :tag => "0.0.1" }
  s.source_files  = "Files/*.{h,m}"
  s.frameworks = "CoreData", "CoreSpotlight"
end
