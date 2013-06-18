$(RDATA_DIR)/mcmcdb_bush_hs: rdata-mcmcdb_bush_hs.R $(RDATA_DIR)/bush_approval $(STAN_DIR)/local_level_hs_inter.stanx 

$(RDATA_DIR)/mcmcsummary_nile_hs: rdata-mcmcsummary_nile_hs.R $(RDATA_DIR)/mcmcdb_nile_hs 

$(RDATA_DIR)/mcmcdb_bush_normal: rdata-mcmcdb_bush_normal.R $(RDATA_DIR)/bush_approval $(STAN_DIR)/local_level_normal_inter.stanx 

$(RDATA_DIR)/mcmcdb_nile_hs: rdata-mcmcdb_nile_hs.R $(RDATA_DIR)/nile $(STAN_DIR)/local_level_hs.stanx 

$(RDATA_DIR)/bush_approval: rdata-bush_approval.R $(DATA_DIR)/bush_approval.csv 

$(RDATA_DIR)/mcmcdb_bush_spline: rdata-mcmcdb_bush_spline.R $(RDATA_DIR)/bush_approval $(STAN_DIR)/spline.stanx 

$(RDATA_DIR)/mcmcsummary_nile_normal_2: rdata-mcmcsummary_nile_normal_2.R $(RDATA_DIR)/mcmcdb_nile_normal_2 

$(RDATA_DIR)/greenbacks: rdata-greenbacks.R $(DATA_DIR)/greenbacks.csv 

$(RDATA_DIR)/mcmcsummary_bush_normal: rdata-mcmcsummary_bush_normal.R $(RDATA_DIR)/mcmcdb_bush_normal 

$(RDATA_DIR)/mcmcsummary_nile_normal_1: rdata-mcmcsummary_nile_normal_1.R $(RDATA_DIR)/mcmcdb_nile_normal_1 

$(RDATA_DIR)/mcmcsummary_greenbacks1: rdata-mcmcsummary_greenbacks1.R $(RDATA_DIR)/mcmcdb_greenbacks1 

$(RDATA_DIR)/mcmcsummary_greenbacks2: rdata-mcmcsummary_greenbacks2.R $(RDATA_DIR)/mcmcdb_greenbacks2 

$(RDATA_DIR)/nile: rdata-nile.R 

$(RDATA_DIR)/mcmcsummary_bush_hs: rdata-mcmcsummary_bush_hs.R $(RDATA_DIR)/mcmcdb_bush_hs 

$(RDATA_DIR)/mcmcdb_nile_normal_1: rdata-mcmcdb_nile_normal_1.R $(RDATA_DIR)/nile $(STAN_DIR)/local_level_normal.stanx nile_data.R 

$(RDATA_DIR)/mcmcdb_bush_spline_hs: rdata-mcmcdb_bush_spline_hs.R $(RDATA_DIR)/bush_approval $(STAN_DIR)/spline_hs.stanx 

$(RDATA_DIR)/mcmcdb_nile_normal_2: rdata-mcmcdb_nile_normal_2.R $(RDATA_DIR)/nile $(STAN_DIR)/local_level_normal_inter.stanx nile_data.R 

