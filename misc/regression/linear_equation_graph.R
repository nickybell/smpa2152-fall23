library(ggplot2)
xs <- rnorm(10, sd = 2.5)
ggplot() +
  geom_point(data = data.frame(x = 4, y = 3), aes(x = x, y = y), size = 3, color = "red") +
  geom_point(data = data.frame(xs = xs, ys = xs*rnorm(10, .5, .05) + rnorm(10, 1, 1)), aes(x = xs, y = ys)) +
  geom_abline(intercept = 1, slope = .5, color = "blue", linetype = "dashed") +
  geom_segment(aes(x = 4, xend = -5, y = 3, yend = 3)) +
  geom_segment(aes(x = 4, xend = 4, y = 3, yend = -5)) +
  geom_segment(aes(x = -5, xend = 0, y = 1, yend = 1), linetype = "dotted") +
  scale_x_continuous(limits = c(-5, 5), breaks = c(-5:5)) +
  scale_y_continuous(limits = c(-5, 5), breaks = c(-5:5)) +
  geom_vline(xintercept = 0, color = "gray70") +
  geom_hline(yintercept = 0, color = "gray70") +
  theme_minimal(base_size = 24) +
  theme(panel.grid = element_blank(),
        plot.background = element_rect(color = "white"))
ggsave("~/Downloads/linear_equation.png", height = 8, width = 8)
