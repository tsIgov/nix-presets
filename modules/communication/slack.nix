{ config, lib, pkgs, ... }:
let
	cfg = config.presets.communication;
in
{
	config = lib.mkIf (cfg.enable && cfg.slack.enable) {
		home.packages = with pkgs; [
			(slack.overrideAttrs (oldAttrs: {
				buildInputs = oldAttrs.buildInputs or [] ++ [ pkgs.makeWrapper ];
				installPhase = oldAttrs.installPhase + ''
					wrapProgram $out/bin/slack \
						--add-flags "--use-angle=vulkan"
				'';
			}))
		];
	};
}
