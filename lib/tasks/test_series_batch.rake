 task :test_series_batch => :environment do 

#SA Equivalency
["LF", "UR", "E_NF", "ECT", "EMN", "E_TTU", "E_EDHC", "E_LH", "EOS", "EGV", "EWT", "ERT", "E_FIR", "ERE", "E_PBS", "EPS", "EED", "EHC", "EAE", "EAF", "EGVFD", "EGVST", "EGVLC", "EMPL"].each do |list| 
  Series.set list+"@HI.M", Series.get(list+"SA@HI.M")
end
 
#9. EXPENDITURE    
#  Series.set "VEXPUSNS@HI.M", Series.get("VEXPUSWNS@HI.M") + Series.get("VEXPUSENS@HI.M")
#  Series.set "VEXPOTNS@HI.M", Series.get("VEXPNS@HI.M") - (Series.get("VEXPUSNS@HI.M") + Series.get("VEXPJPNS@HI.M") + Series.get("VEXPCANNS@HI.M"))
#  Series.set "VEXPNS@MAU.M", Series.get("VEXPNS@MAUI.M") + Series.get("VEXPNS@LAN.M") + Series.get("VEXPNS@MOL.M")
#
#["CAN", "JP", "USE", "USW", "US", "OT"].each do |serlist| 
#  Series.set "VEXPPD"+serlist+"NS@HI.M", (Series.get("VEXP"+serlist+"NS@HI.M") / Series.get("VDAY"+serlist+"NS@HI.M"))*1000
#  Series.set "VEXPPT"+serlist+"NS@HI.M", (Series.get("VEXP"+serlist+"NS@HI.M") / Series.get("VIS"+serlist+"NS@HI.M"))*1000
#end
#
#["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|
#  Series.set "VEXPPDNS@"+cnty+".M", (Series.get("VEXPNS@"+cnty+".M") / Series.get("VDAYNS@"+cnty+".M"))*1000
#  Series.set "VEXPPTNS@"+cnty+".M", (Series.get("VEXPNS@"+cnty+".M") / Series.get("VISNS@"+cnty+".M"))*1000
#end



#["CAN", "JP", "USE", "USW", "DM", "IT"].each do |serlist| 
#["HI", "HON", "HAW", "KAU", "MAU", "MAUI", "MOL", "LAN"].each do |cnty|
#  Series.set "VLOS"+serlist+"NS@"+cnty+".M", Series.get("VDAY"+serlist+"NS@"+cnty+".M") / Series.get("VIS"+serlist+"NS@"+cnty+".M")
#end
#end 
 

#   ["DM", "IT", "CAN", "JP", "USE", "USW"].each do |serlist|
#    ("VRLS#{serlist}NS@MAU.M".ts_eval= %Q|"VRLS#{serlist}NS@MAUI.M".ts * "VIS#{serlist}NS@MAUI.M".ts + "VRLS#{serlist}NS@MOL.M".ts * "VIS#{serlist}NS@MOL.M".ts + "VRLS#{serlist}NS@LAN.M".ts * "VIS#{serlist}NS@LAN.M".ts) / "VIS#{serlist}NS@MAU.M".ts|
#     "VDAY#{serlist}NS@MAU.M".ts_eval= %Q|"VRLS#{serlist}NS@MAU.M".ts * "VIS#{serlist}NS@MAU.M".ts|
#   end
# end
#works
 
# ["HI", "HON", "HAW", "MAU", "KAU"].each do |cnty| 
#   Series.set "ENS@"+cnty+".M", Series.get("E_NFNS@"+cnty+".M") + Series.get("EAGNS@"+cnty+".M") 
#   Series.set "E_TRADENS@"+cnty+".M", Series.get("EWTNS@"+cnty+".M") + Series.get("ERTNS@"+cnty+".M") 
#   Series.set "E_GVSLNS@"+cnty+".M", Series.get("EGVNS@"+cnty+".M") - Series.get("EGVFDNS@"+cnty+".M") 
#   Series.set "E_SVNS@"+cnty+".M", Series.get("E_NFNS@"+cnty+".M") - (Series.get("ECTNS@"+cnty+".M") + Series.get("EMNNS@"+cnty+".M") + Series.get("E_TRADENS@"+cnty+".M") + Series.get("E_TUNS@"+cnty+".M") + Series.get("E_FIRNS@"+cnty+".M") + Series.get("EGVNS@"+cnty+".M"))    
#   Series.set "E_ELSENS@HI.M", Series.get("E_NFNS@HI.M") - (Series.get("ECTNS@HI.M") + Series.get("EMNNS@HI.M") + Series.get("E_TRADENS@HI.M")  + Series.get("E_TUNS@HI.M") + Series.get("E_FIRNS@HI.M") + Series.get("EAFNS@HI.M") + Series.get("EHCNS@HI.M") + Series.get("EGVNS@HI.M"))
# end
# 
# ["HAW", "MAU", "KAU"].each do |cnty| 
#   Series.set "ERENS@"+cnty+".M", Series.get("E_FIRNS@"+cnty+".M") - Series.get("EFINS@"+cnty+".M") 
#   Series.set "EMANS@"+cnty+".M", Series.get("E_PBSNS@"+cnty+".M") - Series.get("EPSNS@"+cnty+".M") - Series.get("EADNS@"+cnty+".M") 
#   Series.set "E_OTNS@"+cnty+".M", Series.get("EMANS@"+cnty+".M") + Series.get("EADNS@"+cnty+".M") + Series.get("EEDNS@"+cnty+".M") + Series.get("EOSNS@"+cnty+".M") 
# end
 
#   Series.set "EUTNS@HON.M", Series.get("E_TUNS@HON.M") - Series.get("ETWNS@HON.M") 
#  
#   Series.set "E_TRADE@HI.M", Series.get("EWT@HI.M") + Series.get("ERT@HI.M")
#   Series.set "E_TU@HI.M", Series.get("E_TTU@HI.M") + Series.get("E_TRADE@HI.M")
#   Series.set "EFI@HI.M", Series.get("E_FIR@HI.M") - Series.get("ERE@HI.M")
#   Series.set "E_GVSL@HI.M", Series.get("EGVST@HI.M") + Series.get("EGVLC@HI.M")
#   Series.set "E_NF@HI.M", Series.get("ECT@HI.M") + Series.get("EMN@HI.M") + Series.get("E_TTU@HI.M") + Series.get("EIF@HI.M") + Series.get("E_FIR@HI.M") + Series.get("E_PBS@HI.M") + Series.get("E_EDHC@HI.M") + Series.get("E_LH@HI.M") + Series.get("EOS@HI.M") + Series.get("EGV@HI.M")
#   Series.set "E_PR@HI.M", Series.get("E_NF@HI.M") - Series.get("EGV@HI.M")
#   Series.set "E_GDSPR@HI.M", Series.get("ECT@HI.M") + Series.get("EMN@HI.M")
#   Series.set "E_SVCPR@HI.M", Series.get("E_NF@HI.M") - Series.get("E_GDSPR@HI.M")
#   Series.set "E_PRSVCPR@HI.M", Series.get("E_SVCPR@HI.M") - Series.get("EGV@HI.M")
#   Series.set "E_SV@HI.M", Series.get("E_NF@HI.M") - (Series.get("ECT@HI.M") + Series.get("EMN@HI.M") + Series.get("E_TTU@HI.M") + Series.get("E_FIR@HI.M") + Series.get("EGV@HI.M"))
#   Series.set "E_ELSE@HI.M", Series.get("E_SV@HI.M") - (Series.get("EAF@HI.M") +Series.get("EHC@HI.M"))
#   Series.set "E@HI.M ", Series.get("E_NF@HI.M") + Series.get("EAG@HI.M")



  
 end

