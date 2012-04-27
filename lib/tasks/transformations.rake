task :cpi => :environment do
  "PC@HON.Q".ts_append_eval %Q|"PC@HON.M".ts.aggregate(:quarter, :average)|
  "PC@HON.Q".ts_append_eval %Q|"PC@HON.S".ts.interpolate :quarter, :linear|
  "PC@HON.A".ts_append_eval %Q|"PC@HON.M".ts.aggregate(:year, :average)|
  "PC@HON.A".ts_append_eval %Q|"PC@HON.S".ts.aggregate(:year, :average)|
  "CPI@HON.S".ts_eval= %Q|"PC@HON.S".ts|
  "CPI@HON.A".ts_eval= %Q|"PC@HON.A".ts|
  "CPI@HON.Q".ts_eval= %Q|"PC@HON.Q".ts|
end

task :CY_FENG => :environment do
  ["HON", "KAU", "MAUI", "MOL", "LAN", "HAW"].each do |cnty|
    #{circular reference}"VRLSDMNS@#{cnty}.M".ts_eval= %Q|"VDAYDMNS@#{cnty}.M".ts / "VISDMNS@#{cnty}.M".ts|
    #{another circular reference}"VRLSITNS@#{cnty}.M".ts_eval= %Q|"VDAYITNS@#{cnty}.M".ts / "VISITNS@#{cnty}.M".ts| This breaks it
    "VRLSUSWNS@#{cnty}.M".ts_eval= %Q|"VDAYUSWNS@#{cnty}.M".ts / "VISUSWNS@#{cnty}.M".ts|
    "VRLSUSENS@#{cnty}.M".ts_eval= %Q|"VDAYUSENS@#{cnty}.M".ts / "VISUSENS@#{cnty}.M".ts|
    "VRLSJPNS@#{cnty}.M".ts_eval= %Q|"VDAYJPNS@#{cnty}.M".ts / "VISJPNS@#{cnty}.M".ts|
    "VRLSCANNS@#{cnty}.M".ts_eval= %Q|"VDAYCANNS@#{cnty}.M".ts / "VISCANNS@#{cnty}.M".ts|
  end
end
  
task :county_visitors => :environment do
  ["HON", "HI", "KAU", "MAU", "HAW"].each do |county| 
    "VIS@#{county}.A".ts_eval= %Q|"VIS@#{county}.M".ts.aggregate(:year, :sum)|
  end
end

task :aggregate_occupancy => :environment do
  ["HON", "HI", "KAU", "MAU", "HAW"].each do |cnty|
   "OCUP%NS@#{cnty}.Q".ts_eval= %Q|"OCUP%NS@#{cnty}.M".ts.aggregate(:quarter, :average)|
   "RMRVNS@#{cnty}.Q".ts_eval= %Q|"RMRVNS@#{cnty}.M".ts.aggregate(:quarter, :average)|
   "PRMNS@#{cnty}.Q".ts_eval= %Q|"PRMNS@#{cnty}.M".ts.aggregate(:quarter, :average)|
  end 
 
  "OCUP%@HI.Q".ts_eval= %Q|"OCUP%@HI.M".ts.aggregate(:quarter, :average)|
  "RMRV@HI.Q".ts_eval= %Q|"RMRV@HI.M".ts.aggregate(:quarter, :average)|
  "PRM@HI.Q".ts_eval= %Q|"PRM@HI.M".ts.aggregate(:quarter, :average)|
end

#this is similar if not a duplicate of expenditures and nbi
# task :maui_visitor_expenses => :environment do
#   "VDAYNS@MAU.M".ts_eval= %Q|"VDAYNS@MAUI.M".ts + "VDAYNS@MOL.M".ts + "VDAYNS@LAN.M".ts|
#   "VEXPNS@MAU.M".ts_eval= %Q|"VEXPNS@MAUI.M".ts + "VEXPNS@MOL.M".ts + "VEXPNS@LAN.M".ts|
#   "VEXPPDNS@MAU.M".ts_eval= %Q|"VEXPNS@MAU.M".ts / "VDAYNS@MAU.M".ts * 1000|
#   "VEXPPTNS@MAU.M".ts_eval= %Q|"VEXPNS@MAU.M".ts / "VISNS@MAU.M".ts * 1000|
#   "VDAYUSNS@MAUI.M".ts_eval= %Q|"VDAYUSENS@MAUI.M".ts + "VDAYUSWNS@MAUI.M".ts|
#   "VDAYUSNS@LAN.M".ts_eval= %Q|"VDAYUSENS@LAN.M".ts + "VDAYUSWNS@LAN.M".ts|
#   "VDAYUSNS@MOL.M".ts_eval=%Q|"VDAYUSENS@MOL.M".ts + "VDAYUSWNS@MOL.M".ts|
# end

task :big_island_visitor_seats => :environment do
  ["VSONS", "VSODMNS", "VSOUSWNS", "VSOITNS", "VSOJPNS", "VSOCANNS"].each do |series|
    "#{series}@HAW.M".ts_eval= %Q|"#{series}@HAWH.M".ts + "#{series}@HAWK.M".ts|
  end
  "VSOJPNS@HAW.M".ts_eval= %Q|"VSOJPNS@HAWH.M".ts.zero_add "VSOJPNS@HAWK.M".ts|
  "VSOITNS@HAW.M".ts_eval= %Q|"VSOITNS@HAWH.M".ts.zero_add "VSOITNS@HAWK.M".ts|
end


task :us_visitor_aggregation => :environment do
  ["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|
    "VISUSNS@#{cnty}.M".ts_append_eval %Q|"VISUSENS@#{cnty}.M".ts + "VISUSWNS@#{cnty}.M".ts|
  end
end
#works

task :cruise_visitors_1 => :environment do
  "VRLSCRAIRNS@HI.M".ts_eval= %Q|"VLOSCRDRNS@HI.M".ts|
  "VLOSCRAIRNS@HI.M".ts_eval= %Q|"VLOSCRDRNS@HI.M".ts|
  "VLOSCRNDNS@HI.M".ts_eval= %Q|"VLOSCRNS@HI.M".ts - "VLOSCRDRNS@HI.M".ts|
  
  ["HON", "HAW", "KAU", "MAU"].each do |cnty|
    "VISCRAIRNS@#{cnty}.M".ts_eval= %Q|"VISCRNS@#{cnty}.M".ts * "VISCRAIRNS@HI.M".ts / "VISCRNS@HI.M".ts|
  end
end

task :cruise_visitors_2 => :environment do
  "VDAYCRAIRNS@HI.M".ts_eval= %Q|"VISCRAIRNS@HI.M".ts * "VLOSCRAIRNS@HI.M".ts|
  
  ["HON", "HAW", "KAU", "MAU"].each do |cnty|
    "VDAYCRAIRNS@#{cnty}.M".ts_eval= %Q|"VISCRAIRNS@#{cnty}.M".ts * "VLOSCRNS@HI.M".ts / 4|
  end
end

task :cruise_visitors_3 => :environment do
  "VDAYCRSHPNS@HI.M".ts_eval= %Q|"VISCRSHPNS@HI.M".ts * "VLOSCRNS@HI.M".ts|

  ["BFNS", "DRNS", "AFNS", "NDNS"].each do |myvar|
    "VDAYCR#{myvar}@HI.M".ts_eval= %Q|"VISCRNS@HI.M".ts * "VLOSCR#{myvar}@HI.M".ts|
    "VDAYCRS#{myvar}@HI.M".ts_eval= %Q|"VISCRSHPNS@HI.M".ts * "VLOSCR#{myvar}@HI.M".ts|
    "VDAYCRA#{myvar}@HI.M".ts_eval= %Q|"VISCRAIRNS@HI.M".ts * "VLOSCR#{myvar}@HI.M".ts|
  end        
end

task :maui_los => :environment do
  ["DM", "IT", "CAN", "JP", "USE", "USW"].each do |serlist| 
    "VRLS#{serlist}NS@MAU.M".ts_eval= %Q|("VRLS#{serlist}NS@MAUI.M".ts * "VIS#{serlist}NS@MAUI.M".ts + "VRLS#{serlist}NS@MOL.M".ts * "VIS#{serlist}NS@MOL.M".ts + "VRLS#{serlist}NS@LAN.M".ts * "VIS#{serlist}NS@LAN.M".ts) / "VIS#{serlist}NS@MAU.M".ts|
    "VDAY#{serlist}NS@MAU.M".ts_eval= %Q|"VRLS#{serlist}NS@MAU.M".ts * "VIS#{serlist}NS@MAU.M".ts|
  end
end
#works

task :maui_vday => :environment do
  ["HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|   #CNTY WITHOUT HI
    "VDAYDMNS@#{cnty}.M".ts_eval= %Q|"VISDMNS@#{cnty}.M".ts * "VRLSDMNS@#{cnty}.M".ts|
    #Causes circular references... do not run
    #{}"VDAYITNS@#{cnty}.M".ts_eval= %Q|"VISITNS@#{cnty}.M".ts * "VRLSITNS@#{cnty}.M".ts|
  end
end
#works

task :all_county_vdays => :environment do
  ["HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|   #CNTY WITHOUT HI
    "VDAYNS@#{cnty}.M".ts_eval= %Q|"VDAYDMNS@#{cnty}.M".ts + "VDAYITNS@#{cnty}.M".ts|
    "VDAYUSNS@#{cnty}.M".ts_eval= %Q|"VDAYUSENS@#{cnty}.M".ts + "VDAYUSWNS@#{cnty}.M".ts|
    "VDAYRESNS@#{cnty}.M".ts_eval= %Q|"VDAYNS@#{cnty}.M".ts - "VDAYUSNS@#{cnty}.M".ts + "VDAYJPNS@#{cnty}.M".ts|
  end
  "VDAYUSNS@HI.M".ts_eval= %Q|"VDAYUSENS@HI.M".ts + "VDAYUSWNS@HI.M".ts|
  "VDAYRESNS@HI.M".ts_eval= %Q|"VDAYNS@HI.M".ts - "VDAYUSNS@HI.M".ts - "VDAYJPNS@HI.M".ts|
end
#works

task :non_us_visitors => :environment do
  ["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty| 
    "VISRESNS@#{cnty}.M".ts_eval= %Q|"VISNS@#{cnty}.M".ts - "VISUSNS@#{cnty}.M".ts - "VISJPNS@#{cnty}.M".ts|
  end
end

task :shares => :environment do
  #this was at top of old file. Don;t know if it's actually used or needed
  #SH_JPNS@HON.Q".ts_eval= %Q|"VISJPNS@HON.Q".ts / "VISJPNS@HI.Q".ts|
  ["HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|   #CNTY WITHOUT HI
    "SH_USNS@#{cnty}.M".ts_eval= %Q|"VISUSNS@#{cnty}.M".ts / "VISUSNS@HI.M".ts|
    "SH_JPNS@#{cnty}.M".ts_eval= %Q|"VISJPNS@#{cnty}.M".ts / "VISJPNS@HI.M".ts|
    "SH_RESNS@#{cnty}.M".ts_eval= %Q|"VISRESNS@#{cnty}.M".ts / "VISRESNS@HI.M".ts|
  end
  "SH_USNS@HI.M".ts_eval= %Q|"SH_USNS@HON.M".ts + "SH_USNS@HAW.M".ts + "SH_USNS@KAU.M".ts + "SH_USNS@MAU.M".ts|
  "SH_JPNS@HI.M".ts_eval= %Q|"SH_JPNS@HON.M".ts + "SH_JPNS@HAW.M".ts + "SH_JPNS@KAU.M".ts + "SH_JPNS@MAU.M".ts|
  "SH_RESNS@HI.M".ts_eval= %Q|"SH_RESNS@HON.M".ts + "SH_RESNS@HAW.M".ts + "SH_RESNS@KAU.M".ts + "SH_RESNS@MAU.M".ts|
end



task :vlos => :environment do
  ["CAN", "JP", "USE", "USW", "DM", "IT"].each do |serlist| 
    ["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|
      "VLOS#{serlist}NS@#{cnty}.M".ts_eval= %Q|"VDAY#{serlist}NS@#{cnty}.M".ts / "VIS#{serlist}NS@#{cnty}.M".ts|
    end
  end
end

#problems
task :quarterly_aggregations => :environment do
  #This series is calculated in a different way
  #"Y_R@HI.Q".ts_eval= %Q|"Y_R@HI.M".ts.aggregate(:quarter, :average)|
  
  "GDP@JP.A".ts_eval= %Q|"GDP@JP.Q".ts.aggregate(:year, :average)|
  "GDP@US.A".ts_eval= %Q|"GDP@US.Q".ts.aggregate(:year, :average)|
  "GDPDEF@JP.A".ts_eval= %Q|"GDPDEF@JP.Q".ts.aggregate(:year, :average)|
  "GDPDEF@US.A".ts_eval= %Q|"GDPDEF@US.Q".ts.aggregate(:year, :average)|
  "GDPPC@US.A".ts_eval= %Q|"GDPPC@US.Q".ts.aggregate(:year, :average)|
  "GDP_C@US.A".ts_eval= %Q|"GDP_C@US.Q".ts.aggregate(:year, :average)|
  "GDP_CD@US.A".ts_eval= %Q|"GDP_CD@US.Q".ts.aggregate(:year, :average)|
  "GDP_CD_R@US.A".ts_eval= %Q|"GDP_CD_R@US.Q".ts.aggregate(:year, :average)|
  "GDP_CG@JP.A".ts_eval= %Q|"GDP_CG@JP.Q".ts.aggregate(:year, :average)|
  "GDP_CG_R@JP.A".ts_eval= %Q|"GDP_CG_R@JP.Q".ts.aggregate(:year, :average)|
  "GDP_CN@US.A".ts_eval= %Q|"GDP_CN@US.Q".ts.aggregate(:year, :average)|
  "GDP_CN_R@US.A".ts_eval= %Q|"GDP_CN_R@US.Q".ts.aggregate(:year, :average)|
  
  #these are all read in
  #"NR@HI.A".ts_eval= %Q|"NR@HI.Q".ts.aggregate(:year, :average)|
  #"NR@HON.A".ts_eval= %Q|"NR@HON.Q".ts.aggregate(:year, :average)|
  #"NR@MAU.A".ts_eval= %Q|"NR@MAU.Q".ts.aggregate(:year, :average)|
  #"NR@KAU.A".ts_eval= %Q|"NR@KAU.Q".ts.aggregate(:year, :average)|
  #"NR@HAW.A".ts_eval= %Q|"NR@HAW.Q".ts.aggregate(:year, :average)|
  # "NBIR@HI.A".ts_eval= %Q|"NBIR@HI.Q".ts.aggregate(:year, :sum)|
  # "NBIR@HON.A".ts_eval= %Q|"NBIR@HON.Q".ts.aggregate(:year, :sum)|
  # "NBIR@MAU.A".ts_eval= %Q|"NBIR@MAU.Q".ts.aggregate(:year, :sum)|
  # "NBIR@KAU.A".ts_eval= %Q|"NBIR@KAU.Q".ts.aggregate(:year, :sum)|
  # "NBIR@HAW.A".ts_eval= %Q|"NBIR@HAW.Q".ts.aggregate(:year, :sum)|
  # "NRM@KAU.A".ts_eval= %Q|"NRM@KAU.Q".ts.aggregate(:year, :sum)|
  # "NRM@HI.A".ts_eval= %Q|"NRM@HI.Q".ts.aggregate(:year, :average)|
end

task :arithmetic_transformations => :environment do
  # don't work
  # "SH_JPNS@HON.Q".ts_eval= %Q|"VISJPNS@HON.Q".ts / "VISJPNS@HI.Q".ts|
  # "VISRESNS@HON.Q".ts_eval= %Q|"VISNS@HON.Q".ts - "VISUSNS@HON.Q".ts - "VISJPNS@HON.Q".ts|
  # "SH_RESNS@HON.Q".ts_eval= %Q|"VISRESNS@HON.Q".ts / "VISRESNS@HI.Q".ts|
  # "SH_JPNS@HI.Q".ts_eval= %Q|"VSH_JPNS@HON.Q".ts + "SH_JPNS@HAW.Q".ts + "SH_JPNS@MAU.Q".ts + "SH_JPNS@KAU.Q".ts|
  # "SH_JPNS@HI.Q".ts_eval= %Q|"SH_RESNS@HON.Q".ts + "SH_RESNS@HAW.Q".ts + "SH_RESNS@MAU.Q".ts + "SH_RESNS@KAU.Q".ts|

  "YPCBEA_R@HI.A".ts_eval= %Q|"Y@HI.A".ts / ("CPI@HON.A".ts * "NR@HI.A".ts)|
  "YPCBEA_R@HON.A".ts_eval= %Q|"Y@HON.A".ts / ("CPI@HON.A".ts * "NR@HON.A".ts)|
  "YPCBEA_R@HAW.A".ts_eval= %Q|"Y@HAW.A".ts / ("CPI@HON.A".ts * "NR@HAW.A".ts)|
  "YPCBEA_R@KAU.A".ts_eval= %Q|"Y@KAU.A".ts / ("CPI@HON.A".ts * "NR@KAU.A".ts)|
  "YPCBEA_R@MAU.A".ts_eval= %Q|"Y@MAU.A".ts / ("CPI@HON.A".ts * "NR@MAU.A".ts)|

  "Y_R@HI.A".ts_eval= %Q|"Y@HI.A".ts / "CPI@HON.A".ts  |
  "Y_R@HON.A".ts_eval= %Q|"Y@HON.A".ts / "CPI@HON.A".ts |
  "Y_R@HAW.A".ts_eval= %Q|"Y@HAW.A".ts / "CPI@HON.A".ts |
  "Y_R@KAU.A".ts_eval= %Q|"Y@KAU.A".ts / "CPI@HON.A".ts |
  "Y_R@MAU.A".ts_eval= %Q|"Y@MAU.A".ts / "CPI@HON.A".ts |

  #works, but might need to be overwritten by rebased version if carl says
  "Y_R@HI.Q".ts_eval= %Q|"Y@HI.Q".ts / "CPI@HON.Q".ts  * 100|
  #"Y_R@HI.Q".ts_eval=       %Q|"Y@HI.Q".ts / "CPI@HON.Q".ts.rebase("2010-01-01") * 100|
  
  #don't work
  # "Y_R@HON.Q".ts_eval= %Q|"Y@HON.Q".ts / "CPI@HON.Q".ts |
  # "Y_R@HAW.Q".ts_eval= %Q|"Y@HAW.Q".ts / "CPI@HON.Q".ts |
  # "Y_R@KAU.Q".ts_eval= %Q|"Y@KAU.Q".ts / "CPI@HON.Q".ts |
  # "Y_R@MAU.Q".ts_eval= %Q|"Y@MAU.Q".ts / "CPI@HON.Q".ts |
end


task :prudential => :environment do
 "PAKRSGF@HI.Q".ts_eval= %Q|(("PAKRSGFNS@HON.Q".ts * "KRSGFNS@HON.Q".ts) + ("PAKRSGFNS@HAW.Q".ts * "KRSGFNS@HAW.Q".ts) + ("PAKRSGFNS@MAU.Q".ts * "KRSGFNS@MAU.Q".ts)  + ("PAKRSGFNS@KAU.Q".ts * "KRSGFNS@KAU.Q".ts))/ "KRSGFNS@HI.Q".ts|
 "PAKRCON@HI.Q".ts_eval= %Q|(("PAKRCONNS@HON.Q".ts * "KRCONNS@HON.Q".ts) + ("PAKRCONNS@HAW.Q".ts * "KRCONNS@HAW.Q".ts) + ("PAKRCONNS@MAU.Q".ts * "KRCONNS@MAU.Q".ts)  + ("PAKRCONNS@KAU.Q".ts * "KRCONNS@KAU.Q".ts))/ "KRCONNS@HI.Q".ts|
 "PAKRSGFNS@HI.Q".ts_eval= %Q|"PAKRSGF@HI.Q".ts|
 "PAKRCONNS@HI.Q".ts_eval= %Q|"PAKRCON@HI.Q".ts|

 
 "YPCBEA_R@HON.A".ts_eval= %Q|"Y@HON.A".ts / ("CPI@HON.A".ts * "NR@HON.A".ts)|
 
 ["HI", "HON", "HAW", "KAU", "MAU"].each do |cnty|
   "Y_R@#{cnty}.A".ts_eval= %Q|"Y@#{cnty}.A".ts / "CPI@HON.A".ts|
   "YPCBEA_R@#{cnty}.A".ts_eval= %Q|"Y@#{cnty}.A".ts / ("CPI@HON.A".ts * "NR@#{cnty}.A".ts)|
 end
end


task :bls_1 => :environment do
  ["HI", "HON", "HAW", "MAU", "KAU"].each do |cnty|
    "ENS@#{cnty}.M".ts_append_eval %Q|"E_NFNS@#{cnty}.M".ts + "EAGNS@#{cnty}.M".ts| 
    "E_TRADENS@#{cnty}.M".ts_append_eval %Q|"EWTNS@#{cnty}.M".ts + "ERTNS@#{cnty}.M".ts| 
    "E_GVSLNS@#{cnty}.M".ts_append_eval %Q|"EGVNS@#{cnty}.M".ts - "EGVFDNS@#{cnty}.M".ts| 
    "E_SVNS@#{cnty}.M".ts_append_eval %Q|"E_NFNS@#{cnty}.M".ts - ("ECTNS@#{cnty}.M".ts + "EMNNS@#{cnty}.M".ts + "E_TRADENS@#{cnty}.M".ts + "E_TUNS@#{cnty}.M".ts + "E_FIRNS@#{cnty}.M".ts + "EGVNS@#{cnty}.M".ts) | 
    "E_ELSENS@HI.M".ts_append_eval %Q|"E_NFNS@HI.M".ts - ("ECTNS@HI.M".ts + "EMNNS@HI.M".ts + "E_TRADENS@HI.M".ts  + "E_TUNS@HI.M".ts + "E_FIRNS@HI.M".ts + "EAFNS@HI.M".ts + "EHCNS@HI.M".ts + "EGVNS@HI.M".ts)|
  end
end

task :bls_2 => :environment do
  ["HAW", "MAU", "KAU"].each do |cnty|
    "ERENS@#{cnty}.M".ts_append_eval %Q|"E_FIRNS@#{cnty}.M".ts - "EFINS@#{cnty}.M".ts| 
    "EMANS@#{cnty}.M".ts_append_eval %Q|"E_PBSNS@#{cnty}.M".ts - "EPSNS@#{cnty}.M".ts - "EADNS@#{cnty}.M".ts| 
    "E_OTNS@#{cnty}.M".ts_append_eval %Q|"EMANS@#{cnty}.M".ts + "EADNS@#{cnty}.M".ts + "EEDNS@#{cnty}.M".ts + "EOSNS@#{cnty}.M".ts| 
  end
end




task :bls_4 => :environment do
  ["HON", "HAW", "MAU", "KAU"].each do |cnty|
    "E_GVSL@#{cnty}.M".ts_append_eval %Q|"EGVST@#{cnty}.M".ts + "EGVLC@#{cnty}.M".ts| 
    "E_EDHC@#{cnty}.M".ts_append_eval %Q|"EED@#{cnty}.M".ts + "EHC@#{cnty}.M".ts| 
    "E_TRADE@#{cnty}.M".ts_append_eval %Q|"EWT@#{cnty}.M".ts + "ERT@#{cnty}.M".ts| 
    "E_TTU@#{cnty}.M".ts_append_eval %Q|"E_TU@#{cnty}.M".ts + "E_TRADE@#{cnty}.M".ts | 
    "E_PR@#{cnty}.M".ts_append_eval %Q|"E_NF@#{cnty}.M".ts - "EGV@#{cnty}.M".ts| 
    "E_GDSPR@#{cnty}.M".ts_append_eval %Q|"ECT@#{cnty}.M".ts + "EMN@#{cnty}.M".ts| 
    "E_SVCPR@#{cnty}.M".ts_append_eval %Q|"E_NF@#{cnty}.M".ts - "E_GDSPR@#{cnty}.M".ts| 
    "E_PRSVCPR@#{cnty}.M".ts_append_eval %Q|"E_SVCPR@#{cnty}.M".ts - "EGV@#{cnty}.M".ts|

    #don't work (some are covered by other calculations... mostly moving averages)
    #{}"EAF@#{cnty}.M".ts_eval= %Q|"EAFAC@#{cnty}.M".ts + "EAFFD@#{cnty}.M".ts|      
    #"EGV@#{cnty}.M".ts_eval= %Q|"EGVFD@#{cnty}.M".ts + "E_GVSL@#{cnty}.M".ts|  
    #"E_LH@#{cnty}.M".ts_eval= %Q|"EAE@#{cnty}.M".ts + "EAF@#{cnty}.M".ts|
    #"E_PBS@#{cnty}.M".ts_eval= %Q|"EPS@#{cnty}.M".ts + "EMA@#{cnty}.M".ts + "EAD@#{cnty}.M".ts| 
    #"E_FIR@#{cnty}.M".ts_eval= %Q|"EFI@#{cnty}.M".ts + "ERE@#{cnty}.M".ts| 
    #"E_NF@#{cnty}.M".ts_eval= %Q|"ECT@#{cnty}.M".ts + "EMN@#{cnty}.M".ts + "E_TTU@#{cnty}.M".ts + "EIF@#{cnty}.M".ts + "E_FIR@#{cnty}.M".ts + "E_PBS@#{cnty}.M".ts + "E_EDHC@#{cnty}.M".ts + "E_LH@#{cnty}.M".ts + "EOS@#{cnty}.M".ts + "EGV@#{cnty}.M".ts| 
    #"E_SV@#{cnty}.M".ts_eval= %Q|"E_NF@#{cnty}.M".ts - ("ECT@#{cnty}.M".ts + "EMN@#{cnty}.M".ts + "E_TTU@#{cnty}.M".ts + "E_FIR@#{cnty}.M".ts + "EGV@#{cnty}.M"))   | 
    #"E_ELSE@#{cnty}.M".ts_eval= %Q|"E_SV@#{cnty}.M".ts - ("EAF@#{cnty}.M".ts + "EHC@#{cnty}.M"))| 
    #"E@#{cnty}.M".ts_eval= %Q|"E_NF@#{cnty}.M".ts + "v@#{cnty}.M".ts| 
    #"UR@#{cnty}.M".ts_eval= %Q|(1-("EMPL@#{cnty}.M".ts / "LF@#{cnty}.M".ts))*100|
  end
end
# #    SERIES ETW@HI.M       = E_TU@HI.M * (MOVAVG(12,ETWNS@HI.M) / MOVAVG(12,E_TUNS@HI.M));
# #    SERIES EUT@HI.M       = E_TU@HI.M * (MOVAVG(12,EUTNS@HI.M) / MOVAVG(12,E_TUNS@HI.M));
# #    SERIES EMA@HI.M       = (E_PBS@HI.M - EPS@HI.M) * (MOVAVG(12,EMANS@HI.M) / MOVAVG(12,(EMANS@HI.M + EADNS@HI.M)));
# #    SERIES EAD@HI.M       = (E_PBS@HI.M - EPS@HI.M) * (MOVAVG(12,EADNS@HI.M) / MOVAVG(12,(EMANS@HI.M + EADNS@HI.M)));
# #    SERIES EAFAC@HI.M     = EAF@HI.M * (MOVAVG(12,EAFACNS@HI.M) / MOVAVG(12,EAFNS@HI.M));
# #    SERIES EAFFD@HI.M     = EAF@HI.M * (MOVAVG(12,EAFFDNS@HI.M) / MOVAVG(12,EAFNS@HI.M));
# #    ! PF: THE SEASONALLY ADJUSTED E_NFSA DOES NOT QUITE MATCH THE SUM OF ITS SEASONALLY ADJUSTED COMPONENTS AT THE MONTHLY FREQUENCY. CALCULATE E_NF AS THE SUM



task :interpolate_quarterly_series => :environment do
  'PC_EN@HON.Q'.ts_eval=      %Q|'PC_EN@HON.S'.ts.interpolate :quarter, :linear|
  'PC_FDEN@HON.Q'.ts_eval=    %Q|'PC_FDEN@HON.S'.ts.interpolate :quarter, :linear|
  'PC_MD@HON.Q'.ts_eval=      %Q|'PC_MD@HON.S'.ts.interpolate :quarter, :linear|
  'PC_SH@HON.Q'.ts_eval=      %Q|'PC_SH@HON.S'.ts.interpolate :quarter, :linear|
  'PCAP@HON.Q'.ts_eval=       %Q|'PCAP@HON.S'.ts.interpolate :quarter, :linear|
  'PCCM@HON.Q'.ts_eval=       %Q|'PCCM@HON.S'.ts.interpolate :quarter, :linear|
  'PCCM_FB@HON.Q'.ts_eval=    %Q|'PCCM_FB@HON.S'.ts.interpolate :quarter, :linear|
  'PCCM_FD@HON.Q'.ts_eval=    %Q|'PCCM_FD@HON.S'.ts.interpolate :quarter, :linear|
  'PCCMDR@HON.Q'.ts_eval=     %Q|'PCCMDR@HON.S'.ts.interpolate :quarter, :linear|
  'PCCMND@HON.Q'.ts_eval=     %Q|'PCCMND@HON.S'.ts.interpolate :quarter, :linear|
  'PCCMND_FB@HON.Q'.ts_eval=  %Q|'PCCMND_FB@HON.S'.ts.interpolate :quarter, :linear|
  'PCCMND_FD@HON.Q'.ts_eval=  %Q|'PCCMND_FD@HON.S'.ts.interpolate :quarter, :linear|
  'PCED@HON.Q'.ts_eval=       %Q|'PCED@HON.S'.ts.interpolate :quarter, :linear|
  'PCEN@HON.Q'.ts_eval=       %Q|'PCEN@HON.S'.ts.interpolate :quarter, :linear|
  'PCFB@HON.Q'.ts_eval=       %Q|'PCFB@HON.S'.ts.interpolate :quarter, :linear|
  'PCFBFD@HON.Q'.ts_eval=     %Q|'PCFBFD@HON.S'.ts.interpolate :quarter, :linear|
  'PCFBFDAW@HON.Q'.ts_eval=   %Q|'PCFBFDAW@HON.S'.ts.interpolate :quarter, :linear|
  'PCFBFDBV@HON.Q'.ts_eval=   %Q|'PCFBFDBV@HON.S'.ts.interpolate :quarter, :linear|
  'PCFBFDHM@HON.Q'.ts_eval=   %Q|'PCFBFDHM@HON.S'.ts.interpolate :quarter, :linear|
  'PCHS@HON.Q'.ts_eval=       %Q|'PCHS@HON.S'.ts.interpolate :quarter, :linear|
  'PCHSFU@HON.Q'.ts_eval=     %Q|'PCHSFU@HON.S'.ts.interpolate :quarter, :linear|
  'PCHSFUEL@HON.Q'.ts_eval=   %Q|'PCHSFUEL@HON.S'.ts.interpolate :quarter, :linear|
  'PCHSFUGS@HON.Q'.ts_eval=   %Q|'PCHSFUGS@HON.S'.ts.interpolate :quarter, :linear|
  'PCHSFUGSE@HON.Q'.ts_eval=  %Q|'PCHSFUGSE@HON.S'.ts.interpolate :quarter, :linear|
  'PCHSFUGSU@HON.Q'.ts_eval=  %Q|'PCHSFUGSU@HON.S'.ts.interpolate :quarter, :linear|
  'PCHSHF@HON.Q'.ts_eval=     %Q|'PCHSHF@HON.S'.ts.interpolate :quarter, :linear|
  'PCHSSH@HON.Q'.ts_eval=     %Q|'PCHSSH@HON.S'.ts.interpolate :quarter, :linear|
  'PCHSSHOW@HON.Q'.ts_eval=   %Q|'PCHSSHOW@HON.S'.ts.interpolate :quarter, :linear|
  'PCHSSHRT@HON.Q'.ts_eval=   %Q|'PCHSSHRT@HON.S'.ts.interpolate :quarter, :linear|
  'PCMD@HON.Q'.ts_eval=       %Q|'PCMD@HON.S'.ts.interpolate :quarter, :linear|
  'PCOT@HON.Q'.ts_eval=       %Q|'PCOT@HON.S'.ts.interpolate :quarter, :linear|
  'PCRE@HON.Q'.ts_eval=       %Q|'PCRE@HON.S'.ts.interpolate :quarter, :linear|
  'PCSV@HON.Q'.ts_eval=       %Q|'PCSV@HON.S'.ts.interpolate :quarter, :linear|
  'PCSV_MD@HON.Q'.ts_eval=    %Q|'PCSV_MD@HON.S'.ts.interpolate :quarter, :linear|
  'PCSV_RN@HON.Q'.ts_eval=    %Q|'PCSV_RN@HON.S'.ts.interpolate :quarter, :linear|
  'PCTR@HON.Q'.ts_eval=       %Q|'PCTR@HON.S'.ts.interpolate :quarter, :linear|
  'PCTRGS@HON.Q'.ts_eval=     %Q|'PCTRGS@HON.S'.ts.interpolate :quarter, :linear|
  'PCTRGSMD@HON.Q'.ts_eval=   %Q|'PCTRGSMD@HON.S'.ts.interpolate :quarter, :linear|
  'PCTRGSPR@HON.Q'.ts_eval=   %Q|'PCTRGSPR@HON.S'.ts.interpolate :quarter, :linear|
  'PCTRGSRG@HON.Q'.ts_eval=   %Q|'PCTRGSRG@HON.S'.ts.interpolate :quarter, :linear|
  'PCTRMF@HON.Q'.ts_eval=     %Q|'PCTRMF@HON.S'.ts.interpolate :quarter, :linear|
  'PCTRPR@HON.Q'.ts_eval=     %Q|'PCTRPR@HON.S'.ts.interpolate :quarter, :linear|

  #special cases with more frequent data
  "PCHSFUEL@HON.Q".ts_append_eval %Q|"PCHSFUEL@HON.M".ts.aggregate(:quarter, :average)|
  "PCHSFUGSE@HON.Q".ts_append_eval %Q|"PCHSFUGSE@HON.M".ts.aggregate(:quarter, :average)|
  "PCHSFUGS@HON.Q".ts_append_eval %Q|"PCHSFUGS@HON.M".ts.aggregate(:quarter, :average)|
end

#first run this. Then run "seasonal adjustment file"
task :distribute_county_shares => :environment do
  ["VIS", "VISUS", "VISJP", "VISRES", "VDAYUS", "VDAYJP", "VDAYRES", "VDAYJP"].each do |s_name|
    ["HON", "HAW", "MAU", "KAU"].each do |county|
      puts "distributing #{s_name}, #{county}"
      start_date = "#{s_name}NS@#{county}.M".ts.first_value_date
      sixth_date = (Date.parse(start_date) >> 17).to_s
      #don't have to do full mean correction here. Happens in seasonal adjustment step
      #("#{s_name}@#{county}.M".ts_append_eval %Q|("#{s_name}NS@#{county}.M".ts.moving_average_for_sa("#{start_date}") / "#{s_name}NS@HI.M".ts.moving_average_for_sa("#{start_date}") * "#{s_name}@HI.M".ts) / ("#{s_name}NS@#{county}.M".ts.moving_average_for_sa("#{start_date}") / "#{s_name}NS@HI.M".ts.moving_average_for_sa("#{start_date}") * "#{s_name}@HI.M".ts).annual_sum * "#{s_name}NS@#{county}.M".ts.annual_sum|) rescue puts "problem with #{s_name}, #{county}"
      ("#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}NS@#{county}.M".ts.moving_average_for_sa("#{start_date}") / "#{s_name}NS@HI.M".ts.moving_average_for_sa("#{start_date}") * "#{s_name}@HI.M".ts|) rescue puts "problem with #{s_name}, #{county}"
      "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}NS@#{county}.M".ts.offset_forward_looking_moving_average("#{start_date}","#{sixth_date}") / "#{s_name}NS@HI.M".ts.offset_forward_looking_moving_average("#{start_date}","#{sixth_date}") * "#{s_name}@HI.M".ts|
      "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}NS@#{county}.M".ts.backward_looking_moving_average.trim / "#{s_name}NS@HI.M".ts.backward_looking_moving_average.trim * "#{s_name}@HI.M".ts|
    end
  end
  
  "EMA@HI.M".ts_eval= %Q|("E_PBS@HI.M".ts - "EPS@HI.M".ts) * "EMANS@HI.M".ts.annual_sum / ("EMANS@HI.M".ts.annual_sum + "EADNS@HI.M".ts.annual_sum)|
  "EAD@HI.M".ts_eval= %Q|("E_PBS@HI.M".ts - "EPS@HI.M".ts) * "EADNS@HI.M".ts.annual_sum / ("EMANS@HI.M".ts.annual_sum + "EADNS@HI.M".ts.annual_sum)|
  #{}"E_NF" is different or maybe not...just needs to be fixed at top level because of identity
  ["ECT", "EMN", "EWT", "ERT", "E_TU", "EED", "EHC", "EAF", "EOS","EGV", "EGVST", "EGVLC","E_NF","EGVFD","EIF", "E_LH", "E_PBS" "E_FIR", "EAE", "EFI", "ERE", "EPS", "EMA", "EAD"].each do |s_name|
    ["HON", "HAW", "MAU", "KAU"].each do |county|
      puts "distributing #{s_name}, #{county}"
      start_date = "#{s_name}NS@#{county}.M".ts.first_value_date
      ("#{s_name}@#{county}.M".ts_eval= %Q|"#{s_name}NS@#{county}.M".ts.annual_average / ("#{s_name}NS@HON.M".ts + "#{s_name}NS@HAW.M".ts + "#{s_name}NS@MAU.M".ts + "#{s_name}NS@KAU.M".ts).annual_average * "#{s_name}@HI.M".ts|) rescue puts "problem with #{s_name}, #{county}"
      "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}NS@#{county}.M".ts.backward_looking_moving_average.trim / ("#{s_name}NS@HON.M".ts + "#{s_name}NS@HAW.M".ts + "#{s_name}NS@MAU.M".ts + "#{s_name}NS@KAU.M".ts).backward_looking_moving_average.trim * "#{s_name}@HI.M".ts|
    end
  end
  
  s_name = "E_NF"
  "E_NF@HON.M".ts.load_sa_from "/Volumes/UHEROwork/data/bls/seasadj/bls_sa_history.xls"
  ["HON", "HAW", "MAU", "KAU"].each do |county|
    puts "distributing #{s_name}, #{county}"
    start_date = "#{s_name}NS@#{county}.M".ts.first_value_date
    ("#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}NS@#{county}.M".ts.annual_average / ("#{s_name}NS@HON.M".ts + "#{s_name}NS@HAW.M".ts + "#{s_name}NS@MAU.M".ts + "#{s_name}NS@KAU.M".ts).annual_average * "#{s_name}@HI.M".ts|) rescue puts "problem with #{s_name}, #{county}"
#    "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}NS@#{county}.M".ts.backward_looking_moving_average.trim / ("#{s_name}NS@HON.M".ts + "#{s_name}NS@HAW.M".ts + "#{s_name}NS@MAU.M".ts + "#{s_name}NS@KAU.M".ts).backward_looking_moving_average.trim * "#{s_name}@HI.M".ts|
  end
end

task :distribute_county_shares_3 => :environment do
  ["VISDM","VISIT"].each do |s_name|
    ["HON", "HAW", "MAU", "KAU"].each do |county|
      puts "distributing #{s_name}, #{county}"
      start_date = "#{s_name}NS@#{county}.M".ts.first_value_date
      sixth_date = (Date.parse(start_date) >> 17).to_s
      
      #("#{s_name}@#{county}.M".ts_eval= %Q|("#{s_name}NS@#{county}.M".ts.moving_average_for_sa("#{start_date}") / "#{s_name}NS@HI.M".ts.moving_average_for_sa("#{start_date}") * "#{s_name}@HI.M".ts) / ("#{s_name}NS@#{county}.M".ts.moving_average_for_sa("#{start_date}") / "#{s_name}NS@HI.M".ts.moving_average_for_sa("#{start_date}") * "#{s_name}@HI.M".ts).annual_sum * "#{s_name}NS@#{county}.M".ts.annual_sum|) rescue puts "problem with #{s_name}, #{county}"
      ("#{s_name}@#{county}.M".ts_eval= %Q|"#{s_name}NS@#{county}.M".ts.moving_average_for_sa("#{start_date}") / "#{s_name}NS@HI.M".ts.moving_average_for_sa("#{start_date}") * "#{s_name}@HI.M".ts|) rescue puts "problem with #{s_name}, #{county}"
      "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}NS@#{county}.M".ts.offset_forward_looking_moving_average("#{start_date}","#{sixth_date}") / "#{s_name}NS@HI.M".ts.offset_forward_looking_moving_average("#{start_date}","#{sixth_date}") * "#{s_name}@HI.M".ts|
      "#{s_name}_MC@#{county}.M".ts_eval= %Q|"#{s_name}@#{county}.M".ts / "#{s_name}@#{county}.M".ts.annual_sum * "#{s_name}NS@#{county}.M".ts.annual_sum|
      "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}_MC@#{county}.M".ts|
      
      "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}NS@#{county}.M".ts.backward_looking_moving_average.trim / "#{s_name}NS@HI.M".ts.backward_looking_moving_average.trim * "#{s_name}@HI.M".ts|
    end
  end
end

task :distribute_county_shares_2 => :environment do
  ["LF", "EMPL"].each do |s_name|
    ["HON", "HAW", "MAU", "KAU"].each do |county|
      puts "distributing #{s_name}, #{county}"
      start_date = "#{s_name}NS@#{county}.M".ts.first_value_date
      #("#{s_name}@#{county}.M".ts_eval= %Q|"#{s_name}NS@#{county}.M".ts.annual_sum / "#{s_name}NS@HI.M".ts.annual_sum * "#{s_name}@HI.M".ts|) rescue puts "problem with #{s_name}, #{county}"
      ("#{s_name}@#{county}.M".ts_eval= %Q|"#{s_name}NS@#{county}.M".ts.annual_sum / ("#{s_name}NS@HON.M".ts.annual_sum + "#{s_name}NS@HAW.M".ts.annual_sum + "#{s_name}NS@MAU.M".ts.annual_sum + "#{s_name}NS@KAU.M".ts.annual_sum) * "#{s_name}@HI.M".ts|) rescue puts "problem with #{s_name}, #{county}"
      "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}NS@#{county}.M".ts.backward_looking_moving_average.trim / "#{s_name}NS@HI.M".ts.backward_looking_moving_average.trim * "#{s_name}@HI.M".ts|
    end
  end
  
  ["HON", "HAW", "MAU", "KAU"].each do |county|
    puts "distributing UR, #{county}"
    ("UR@#{county}.M".ts_eval= %Q|(("EMPL@#{county}.M".ts / "LF@#{county}.M".ts) * -1 + 1)*100|) rescue puts "problem with UR, #{county}"
  end
end

task :distribute_county_shares_other => :environment do
  ["EAFAC", "EAFFD"].each do |s_name|
    ["HON","HAW","MAU","KAU"].each do |county|
      puts "distributing #{s_name}, #{county}"
      #("#{s_name}@#{county}.M".ts_eval= %Q|"#{s_name}NS@#{county}.M".ts.moving_average / "#{s_name}NS@HI.M".ts.moving_average * "#{s_name}@HI.M".ts|) rescue puts "problem with #{s_name}, #{county}"
      ("#{s_name}@#{county}.M".ts_eval= %Q|"#{s_name}NS@#{county}.M".ts.annual_average / ("#{s_name}NS@HON.M".ts + "#{s_name}NS@HAW.M".ts + "#{s_name}NS@MAU.M".ts + "#{s_name}NS@KAU.M".ts ).annual_average * "#{s_name}@HI.M".ts|) #rescue puts "problem with #{s_name}, #{county}"
      "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}NS@#{county}.M".ts.backward_looking_moving_average.trim / ("#{s_name}NS@HON.M".ts + "#{s_name}NS@HAW.M".ts + "#{s_name}NS@MAU.M".ts + "#{s_name}NS@KAU.M".ts ).backward_looking_moving_average.trim * "#{s_name}@HI.M".ts|
      
    end
  end
end

task :sa_equivalency => :environment do
  "EMN@HI.M".ts.apply_seasonal_adjustment :multiplicative #do this instead. Still doesn't exactly match
  #not all of these are good ("EMN" seems to be a problem at least) #removed on 12/14
  ["LF", "UR", "E_NF", "ECT", "E_TTU", "E_EDHC", "E_LH", "EOS", "EGV", "EWT", "ERT", "E_FIR", "ERE", "E_PBS", "EPS", "EED", "EHC", "EAE", "EAF", "EGVFD", "EGVST", "EGVLC", "EMPL"].each do |list|
    "#{list}@HI.M".ts_append_eval %Q|"#{list}SA@HI.M".ts|
  end
end

#run distribute_county_shares first
task :seasonal_adjustments => :environment do
  ["VDAYDM", "VDAYIT"].each do |s_name|
      county = "HI"
      puts "mean adjusting #{s_name} @ #{county}"
      "#{s_name}_MC@#{county}.M".ts_eval= %Q|"#{s_name}@#{county}.M".ts / "#{s_name}@#{county}.M".ts.annual_sum * "#{s_name}NS@#{county}.M".ts.annual_sum|
      "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}_MC@#{county}.M".ts|
      mult_factors = ["VISDM", "VDAYJP", "VISJP"]
      "#{s_name}@#{county}.M".ts.apply_seasonal_adjustment :additive if mult_factors.index(s_name).nil?
      "#{s_name}@#{county}.M".ts.apply_seasonal_adjustment :multiplicative unless mult_factors.index(s_name).nil?
  end
  
  ["VDAYUS", "VDAYJP", "VDAYRES","VISUS","VISJP","VISRES"].each do |s_name|
     ["HI","HON", "HAW", "MAU", "KAU"].each do |county|
        puts "mean adjusting #{s_name} @ #{county}"
        "#{s_name}_MC@#{county}.M".ts_eval= %Q|"#{s_name}@#{county}.M".ts / "#{s_name}@#{county}.M".ts.annual_sum * "#{s_name}NS@#{county}.M".ts.annual_sum|
        "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}_MC@#{county}.M".ts|
      end
    end

    ["HI","HON", "HAW", "MAU", "KAU"].each do |county|
      "VIS@#{county}.M".ts_append_eval %Q|"VISJP@#{county}.M".ts + "VISUS@#{county}.M".ts + "VISRES@#{county}.M".ts|  
      "VDAY@#{county}.M".ts_append_eval %Q|"VDAYJP@#{county}.M".ts + "VDAYUS@#{county}.M".ts + "VDAYRES@#{county}.M".ts| 
    end
end


task :distribute_quarterly_county_shares => :environment do
  ["OCUP%", "PRM", "RMRV"].each do |s_name|
    ["HON", "HAW", "MAU", "KAU"].each do |county|
      puts "distributing #{s_name}, #{county}"
      ("#{s_name}@#{county}.Q".ts_eval= %Q|(("#{s_name}NS@#{county}.M".ts.moving_average / "#{s_name}NS@HI.M".ts.moving_average * "#{s_name}@HI.M".ts) / ("#{s_name}NS@#{county}.M".ts.moving_average / "#{s_name}NS@HI.M".ts.moving_average * "#{s_name}@HI.M".ts).annual_sum * "#{s_name}NS@#{county}.M".ts.annual_sum).aggregate :quarter, :average|)  rescue puts "problem distributing #{s_name} to #{county}"
      #"#{s_name}NS@#{county}.M".ts.aggregate_to :quarter, :average, "#{s_name}NS@#{county}.Q" rescue puts "problems aggregating #{s_name}, #{county}" 
    end
  end
  
  # ["KRSGF"].each do |s_name|
  #   ["HON", "HAW", "MAU", "KAU"].each do |county|
  #     puts "distributing #{s_name}, #{county}"
  #     ("#{s_name}@#{county}.Q".ts_eval= %Q|(("#{s_name}NS@#{county}.Q".ts.moving_average / "#{s_name}NS@HI.Q".ts.moving_average * "#{s_name}@HI.Q".ts) / ("#{s_name}NS@#{county}.M".ts.moving_average / "#{s_name}NS@HI.M".ts.moving_average * "#{s_name}@HI.M".ts).annual_sum * "#{s_name}NS@#{county}.M".ts.annual_sum).aggregate :quarter, :average|)  rescue puts "problem distributing #{s_name} to #{county}"
  #     #"#{s_name}NS@#{county}.M".ts.aggregate_to :quarter, :average, "#{s_name}NS@#{county}.Q" rescue puts "problems aggregating #{s_name}, #{county}" 
  #   end
  # end
end

task :special_bls_identities => :environment do
  ["HON", "HAW", "MAU", "KAU"].each do |county|
    puts county
    "EGV@#{county}.M".ts_append_eval      %Q|"EGVFD@#{county}.M".ts + "E_GVSL@#{county}.M".ts|
    "EAF@#{county}.M".ts_eval=            %Q|"EAFAC@#{county}.M".ts + "EAFFD@#{county}.M".ts|
    "E_LH@#{county}.M".ts_append_eval     %Q|"EAE@#{county}.M".ts + "EAF@#{county}.M".ts|
    "E_EDHC@#{county}.M".ts_append_eval   %Q|"EED@#{county}.M".ts + "EHC@#{county}.M".ts|
    "E_PBS@#{county}.M".ts_append_eval    %Q|"EPS@#{county}.M".ts + "EMA@#{county}.M".ts + "EAD@#{county}.M".ts|
    "E_FIR@#{county}.M".ts_append_eval    %Q|"EFI@#{county}.M".ts + "ERE@#{county}.M".ts|
    "E_TRADE@#{county}.M".ts_append_eval  %Q|"EWT@#{county}.M".ts + "ERT@#{county}.M".ts|
    "E_TTU@#{county}.M".ts_append_eval    %Q|"E_TU@#{county}.M".ts + "E_TRADE@#{county}.M".ts|
    "E_NF@#{county}.M".ts_append_eval      %Q|"ECT@#{county}.M".ts + "EMN@#{county}.M".ts + "E_TTU@#{county}.M".ts + "EIF@#{county}.M".ts + "E_FIR@#{county}.M".ts + "E_PBS@#{county}.M".ts + "E_EDHC@#{county}.M".ts + "E_LH@#{county}.M".ts + "EOS@#{county}.M".ts + "EGV@#{county}.M".ts|
  end
end

task :ben_assorted_transformations => :environment do
  "VLOS@HI.M".ts_eval=      %Q|"VDAY@HI.M".ts / "VIS@HI.M".ts|
  #{}"EAFAC@HI.M".ts_eval=     %Q|"EAFACNS@HI.M".ts.annual_average / "EAF@HI.M".ts.annual_average * "EAF@HI.M".ts|
  #{}"EAFFD@HI.M".ts_eval=     %Q|"EAFFDNS@HI.M".ts.annual_average / "EAF@HI.M".ts.annual_average * "EAF@HI.M".ts|
  
  "EAFFD@HI.M".ts_eval= %Q|"EAFFDNS@HI.M".ts.annual_average / "EAFNS@HI.M".ts.annual_average * "EAF@HI.M".ts|
  "EAFFD@HI.M".ts_append_eval %Q|"EAFFDNS@HI.M".ts.backward_looking_moving_average.trim / "EAFNS@HI.M".ts.backward_looking_moving_average.trim * "EAF@HI.M".ts|
  "EAFAC@HI.M".ts_eval= %Q|"EAFACNS@HI.M".ts.annual_average / "EAFNS@HI.M".ts.annual_average * "EAF@HI.M".ts|
  "EAFAC@HI.M".ts_append_eval %Q|"EAFACNS@HI.M".ts.backward_looking_moving_average.trim / "EAFNS@HI.M".ts.backward_looking_moving_average.trim * "EAF@HI.M".ts|
  
  
  "Y_R@HI.Q".ts_eval=       %Q|"Y@HI.Q".ts / "CPI@HON.Q".ts.rebase("2010-01-01") * 100|
  "INFCORE@HON.Q".ts_eval=  %Q|"PC_FDEN@HON.Q".ts.annualized_percentage_change|
  "INF@HON.Q".ts_eval=      %Q|"CPI@HON.Q".ts.rebase("2010-01-01").annualized_percentage_change|
  "INF_SH@HON.Q".ts_eval=   %Q|"PC_SH@HON.Q".ts.annualized_percentage_change|
end

task :general_arithmethic_transformation => :environment do
  "Y_R@HON.A".ts_eval=      %Q|"Y@HON.A".ts / "CPI@HON.A".ts|
end



# task :seasonal_adjustments_2 => :environment do
#   ["LF","EMPL"].each do |s_name|
#      ["HI","HON", "HAW", "MAU", "KAU"].each do |county|
#         puts "mean adjusting #{s_name} @ #{county}"
#         "#{s_name}_MC@#{county}.M".ts_eval= %Q|"#{s_name}@#{county}.M".ts / "#{s_name}@#{county}.M".ts.annual_sum * "#{s_name}NS@#{county}.M".ts.annual_sum|
#         "#{s_name}@#{county}.M".ts_append_eval %Q|"#{s_name}_MC@#{county}.M".ts|
# #        mult_factors = ["VISDM", "VDAYJP", "VISJP"]
# #        "#{s_name}@#{county}.M".ts.apply_seasonal_adjustment :additive if mult_factors.index(s_name).nil?
# #        "#{s_name}@#{county}.M".ts.apply_seasonal_adjustment :multiplicative unless mult_factors.index(s_name).nil?
#       end
#     end
#end

# task :county_mean_corrections => :environment do
#   ["KRSGFNS","KRCONNS"].each do |s_name|
#     ["HON","HAW","MAU","KAU"].each do |county|
#       "#{s_name}_MC@#{county}.Q".ts_eval= %Q|"#{s_name}@#{county}.Q".ts / ("#{s_name}@HON.Q".ts + "#{s_name}@HAW.Q".ts + "#{s_name}@MAU.Q".ts + "#{s_name}@KAU.Q".ts) * "#{s_name}@HI.Q".ts| 
#     end
#     
#     ["HON","HAW","MAU","KAU"].each do |county|
#       "#{s_name}@#{county}.Q".ts_append_eval %Q|"#{s_name}_MC@#{county}.Q".ts.round| 
#     end
#   end
# end

# task :vis => :environment do
#   "VISDEMETRA_MC@HI.M".ts_eval= %Q|"VIS@HI.M".ts.load_mean_corrected_sa_from "/Volumes/UHEROwork/data/tour/seasadj/sadata.xls"|
#   "VIS@HAW.M".ts_append_eval %Q|"VISDEMETRA_MC@HI.M".ts.mc_ma_county_share_for("HAW","VIS")|
#   "VISJP@HAW.M".ts + "VISUS@HAW.M".ts + "VISRES@HAW.M".ts
# end



