FROM rocker/r-ver
WORKDIR /usr/workspace
RUN install2.r --error MASS
COPY . .
CMD ["Rscript", "src/Simulate_data_opt2.R"]
