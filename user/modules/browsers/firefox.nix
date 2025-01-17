{ pkgs, config, lib, ... }:
let
	cfg = config.presets.browsers;
in
{
	programs.firefox = lib.mkIf cfg.enable {
		enable = true;
		package = pkgs.firefox;
		policies = {
			AutofillAddressEnabled = false;
			AutofillCreditCardEnabled = false;
			CaptivePortal = true;
			DisableFirefoxStudies = true;
			DisablePocket = true;
			DisableFormHistory = true;
			DisableTelemetry = true;
			DontCheckDefaultBrowser = true;
			DefaultDownloadDirectory = "~/Downloads";
			EnableTrackingProtection = {
				Value = true;
				Cryptomining = true;
				Fingerprinting = true;
				EmailTracking = true;
			};
			Homepage = {
				StartPage = "previous-session";
			};
			NoDefaultBookmarks = true;
			OfferToSaveLogins = false;
			OfferToSaveLoginsDefault = false;
			OverrideFirstRunPage = "";
			PasswordManagerEnabled = false;
			PictureInPicture = {
				Enabled = false;
			};
			PopupBlocking = {
				Default = true;
			};
			SearchSuggestEnabled = false;
			TranslateEnabled = false;
			FirefoxHome = {
				Highlights = false;
				Pocket = false;
				Search = true;
				Snippets = false;
				SponsoredPocket = false;
				SponsoredTopSites = false;
				TopSites = false;
			};
			FirefoxSuggest = {
				SponsoredSuggestions = false;
				ImproveSuggest = false;
				WebSuggestions = false;
			};
			UserMessaging = {
				ExtensionRecommendations = false;
				FeatureRecommendations = false;
				MoreFromMozilla = false;
				FirefoxLabs = false;
				SkipOnboarding = true;
			};
		};
		profiles = {
			"default" = {
				isDefault = true;
				userChrome = ''
					#sidebar-box #sidebar-header {
						display: none !important;
					}

					#TabsToolbar {
						display: none !important;
					}
				'';
				settings = {
					"browser.tabs.hoverPreview.enabled" = false;
					"browser.tabs.hoverPreview.showThumbnails" = false;
					"browser.urlbar.suggest.addons" = false;
					"browser.urlbar.suggest.bookmark" = true;
					"browser.urlbar.suggest.calculator" = false;
					"browser.urlbar.suggest.clipboard" = false;
					"browser.urlbar.suggest.engines" = false;
					"browser.urlbar.suggest.fakespot" = false;
					"browser.urlbar.suggest.history" = true;
					"browser.urlbar.suggest.pocket" = false;
					"browser.urlbar.suggest.quickactions" = false;
					"browser.urlbar.suggest.recentsearches" = true;
					"browser.urlbar.suggest.remotetab" = false;
					"browser.urlbar.suggest.topsites" = false;
					"browser.urlbar.suggest.trending" = false;
					"browser.urlbar.suggest.weather" = false;
					"browser.urlbar.suggest.yelp" = false;
					"media.hardwaremediakeys.enabled" = false;
					"privacy.donottrackheader.enabled" = true;
					"privacy.globalprivacycontrol.enabled" = true;
					"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
				};
				search = {
					force = true;
					engines = {
						"Nix Packages" = {
							urls = [{
								template = "https://search.nixos.org/packages";
								params = [
									{ name = "channel"; value = "unstable"; }
									{ name = "query"; value = "{searchTerms}"; }
								];
							}];

							icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
							definedAliases = [ "@no" ];
						};

						"Nix Options" = {
							urls = [{
								template = "https://search.nixos.org/options";
								params = [
									{ name = "channel"; value = "unstable"; }
									{ name = "query"; value = "{searchTerms}"; }
								];
							}];

							icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
							definedAliases = [ "@no" ];
						};

						"Home Manager Options" = {
							urls = [{
								template = "https://home-manager-options.extranix.com";
								params = [
									{ name = "release"; value = "master"; }
									{ name = "query"; value = "{searchTerms}"; }
								];
							}];
							icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
							definedAliases = [ "@hm" ];
						};

						"Google".metaData.alias = "@g";
						"Wikipedia (en)".metaData.alias = "@wp";
					};
				};
				containers = {
					Personal = {
						color = "blue";
						icon = "fingerprint";
						id = 1;
					};
					Work = {
						color = "purple";
						icon = "briefcase";
						id = 2;
					};
				};
			};
		};
	};
}