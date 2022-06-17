library(ggplot2)
library(shiny)
library(gganimate)
library(gapminder)
theme_set(theme_bw())

View(gapminder)
#graph animation working with:bin_2d, boxplot, col, count, rug, tile, hex, point 
#only graph image (exclude animation):bin2d, density_2d, line, path
gplot <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_line(alpha = 0.7) +
  scale_color_manual(values = country_colors) +
  scale_size(range = c(2,15)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  theme(legend.position = 'none') +
  theme(axis.text = element_text(size = 20), axis.title = element_text(size = 22, face = 'bold'), 
        strip.text = element_text(size = 20))

print(gplot)
gplot2 <- gplot + labs(title = 'Year: {frame_time}', x = 'GDP Per Capita', 
                       y = 'Life Expectancy') +
  transition_time(year) +
  theme(plot.title = element_text(size = 23, face = 'bold'))

animate(gplot2, nframes=120, renderer=gifski_renderer('gdp_percapita2.gif'),
        height = 700, width = 1000)

    
    