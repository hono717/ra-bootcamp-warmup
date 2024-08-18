install.packages("tidyverse") 
setwd("C:/Users/hono1/OneDrive/デスクトップ/ra-bootcamp-warmup")
getwd()
semester_1 <- read.csv("semester_data_1.csv", header = TRUE)
semester_2 <- read.csv("semester_data_2.csv", header = TRUE)
str(semester_1)
colnames(semester_1) <- semester_1[1, ]
# 1列目を削除
semester_1 <- semester_1[-1, ]
# semester_2のデータ型を調整
semester_2 <- type.convert(semester_2, as.is = TRUE)
# semester_1の列名を取得
column_names_data1 <- names(semester_1)
# semester_2の列名をsemester_1に合わせる
names(semester_2) <- column_names_data1
# 2つを結合
combined_data <- rbind(semester_1, semester_2)
library(dplyr)
# Y列削除
combined_data <- select(combined_data, -Y)
# 導入年の特定
introduction_years <- combined_data %>%
  filter(semester == 1) %>%
  group_by(unitid) %>%
  summarize(Semester_Introduction_Year = min(year), .groups = 'keep')
merged_data <- merge(combined_data, introduction_years, by = "unitid", all.x = TRUE)
# ダミー変数の追加
merged_data <- merged_data %>%
  mutate(semester_dummy = ifelse(year >= Semester_Introduction_Year, 1, 0))
