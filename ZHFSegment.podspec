

Pod::Spec.new do |spec|

  spec.name         = "ZHFSegment"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of ZHFSegment."
  spec.description  = <<-DESC
上传测试ZHFSegment
                   DESC

  spec.homepage     = "https://github.com/FighterLightning/ZHFSegment"
 
  spec.license      = "MIT"
  
  spec.author             = { "zhanghaifeng" => "18500473583@163.com" }
 
  spec.platform     = :ios, "8.0"

  

  spec.source       = { :git => "https://github.com/FighterLightning/ZHFSegment.git", :tag => spec.version }


 
  spec.source_files  = "ZHFSegment/**/*.{swift}"
 
  spec.requires_arc = true

end
