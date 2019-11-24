# Robot simulator
This is a robot simulator which implemented by ruby

## How to Run

### in Docker
```bash
docker build -t robot-challenge .
docker run --rm -it --name robot-challenge-app robot-challenge

# in the container
# test
rspec

# code format
rubocop

# run simulator with script_file
./scripts/robot_simulator.rb example_files/example_a

# run simulator cli. play according to help info
./scripts/robot_simulator.rb

```

### local

```bash
# install gems
bundle install

# test
# coverage/index.html shows test coverage details
rspec

# code format
rubocop

# run simulator with script_file
./scripts/robot_simulator.rb example_files/example_a

# run simulator cli. play according to help info
./scripts/robot_simulator.rb

```