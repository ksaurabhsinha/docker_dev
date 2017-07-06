define message
	@echo "${LIGHT_GREEN} ========================================================${NC}"
	@echo "${LIGHT_GREEN}  $(1)"
	@echo "${LIGHT_GREEN} ========================================================${NC}"
endef

intro_text:
	@echo "${LIGHT_GREEN}"
	@echo "      ___                    ___                                   ___                    "
	@echo "      MM                     MM                                    MM                     "
	@echo "      MM                     MM                                    MM                     "
	@echo "  ____MM   _____     ____    MM   __    ____   ___  __         ____MM   ____   ____    ___"
	@echo " 6MMMMMM  6MMMMMb   6MMMMb.  MM   d    6MMMMb   MM 6MM        6MMMMMM  6MMMMb   MM(    )M'"
	@echo "6M    MM 6M     Mb 6M    Mb  MM  d    6M'   Mb  MM69         6M    MM 6M    Mb   Mb    d  "
	@echo "MM    MM MM     MM MM    |'  MM d     MM    MM  MM'          MM    MM MM    MM   YM.  ,P  ${RED}"
	@echo "MM    MM MM     MM MM        MMdM.    MMMMMMMM  MM           MM    MM MMMMMMMM    MM  M   "
	@echo "MM    MM MM     MM MM        MMPYM.   MM        MM           MM    MM MM           Mbd'   "
	@echo "YM.  ,MM YM.   ,M9 YM.   d9  MM  YM.  YM    d9  MM           YM.  ,MM YM    d9     YMP    "
	@echo " YMMMMMM_ YMMMMM9   YMMMM9  _MM_  YM._ YMMMM9  _MM_           YMMMMMM_ YMMMM9       M"
	@echo "${LIGHT_GREEN}"
	@echo "==========================================================================================="
	@echo "${NC}"
