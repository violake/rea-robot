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

```