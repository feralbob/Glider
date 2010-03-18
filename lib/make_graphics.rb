#!/opt/local/bin/ruby

# convert -background black -fill \#ffdc5d -font ./Estilo.otf -pointsize 44 label:glider -crop 100%x46+0+10\! foo.gif

def make_graphic(text, colour, size)
  `convert -background black -fill #{colour} -font ./Estilo.otf -pointsize #{size} label:#{text} -crop 100%x46+0+#{ (size/4).to_i}\! #{text}.gif`

end

text_strings = [
  {:text => 'glider', :colour => '\#ffdc5d', :size => 44},
  {:text => 'slides', :colour => 'grey', :size => 25},
  {:text => 'chains', :colour => 'grey', :size => 25},
  {:text => 'displays', :colour => 'grey', :size => 25},
  {:text => 'chat', :colour => 'grey', :size => 25},
  {:text => 'questions', :colour => 'grey', :size => 25}
]

text_strings.each do |arr|
  make_graphic(arr[:text], arr[:colour], arr[:size])
end

`mv *.gif ../public/images/`
