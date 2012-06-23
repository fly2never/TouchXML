Pod::Spec.new do |s|
	s.name     = 'TouchXML_gs'
	s.version  = '0.1'
	s.license  = 'Simplified BSD License'
	s.summary  = "TouchXML is a lightweight replacement for Cocoa's NSXML* cluster of classes. Forked by fly2never"
	s.homepage = 'https://github.com/fly2never/TouchXML'
	s.author   = { 'Jonathan Wight' => 'schwa@toxicsoftware.com' }
	s.source   = { :git => 'git://github.com/fly2never/TouchXML.git', :commit => 'bc1781ac5cf005d61c3e9d1076002772933a08f5'}
	s.source_files = 'Source/**/*.{h,m}'
	s.requires_arc = true
	s.library      = 'xml2'
	s.xcconfig     = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
	s.clean_paths  = '*.xcodeproj', 'Documentation', 'Support'
end
