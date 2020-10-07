# Make SEED RL visible to Python.
export PYTHONPATH=$PYTHONPATH:$(pwd)
WORKINGPATH=$(pwd)
ENVIRONMENT=football
AGENT=vtrace
NUM_ACTORS=4
shift 3

# Start actor tasks which run environment loop.
actor=0
while [ "$actor" -lt ${NUM_ACTORS} ]; do
  python3 seed_rl/${ENVIRONMENT}/${AGENT}_main.py --run_mode=actor --logtostderr --total_environment_frames=10000 --game=11_vs_11_kaggle --reward_experiment=scoring,checkpoints --logdir=${WORKINGPATH}/kaggle_simulations/agent/ --num_actors=${NUM_ACTORS} --task=${actor} 2>/dev/null >/dev/null &
  actor=$(( actor + 1 ))
done
# Start learner task which performs training of the agent.
python3 seed_rl/${ENVIRONMENT}/${AGENT}_main.py --run_mode=learner --logtostderr --total_environment_frames=10000 --game=11_vs_11_kaggle --reward_experiment=scoring,checkpoints --logdir=${WORKINGPATH}/kaggle_simulations/agent/ --num_actors="${NUM_ACTORS}"