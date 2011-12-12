def p
  Series.new.load_from_pattern(self).print
end

def attach_to(series_name)
  series_name.ts_append_eval %Q|"#{series_name}".ts.load_from_pattern_id "#{self.id}"|
end