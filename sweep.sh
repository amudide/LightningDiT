#!/bin/bash

# Path to the original config file
TEMPLATE_CONFIG="configs/reproductions/lightningdit_xl_vavae_f16d32_800ep_cfg.yaml"

# Values for `skip`, `cfg_scale`, and `cfg_interval_start`
SKIP_VALUES=(7)
CFG_SCALE_VALUES=(1.05 1.10 1.15)
CFG_INTERVAL_START_VALUES=(0.0)  # Add your desired values

# Loop through each combination
for SKIP in "${SKIP_VALUES[@]}"; do
  for CFG_SCALE in "${CFG_SCALE_VALUES[@]}"; do
    for CFG_INTERVAL_START in "${CFG_INTERVAL_START_VALUES[@]}"; do
      CONFIG_PATH="config_skip_${SKIP}_cfgscale_${CFG_SCALE}_cfginterval_${CFG_INTERVAL_START}.yaml"

      # Replace values in the template config
      sed -e "s/skip: \[.*\]/skip: [$SKIP]/" \
          -e "s/cfg_scale: .*/cfg_scale: $CFG_SCALE/" \
          -e "s/cfg_interval_start: .*/cfg_interval_start: $CFG_INTERVAL_START/" \
          "$TEMPLATE_CONFIG" > "$CONFIG_PATH"

      echo "Running script with skip=$SKIP, cfg_scale=$CFG_SCALE, cfg_interval_start=$CFG_INTERVAL_START"
      ./run_inference.sh "$CONFIG_PATH"

      # Optional cleanup
      rm "$CONFIG_PATH"
    done
  done
done
