nums <- sample(x = 10:100, size = 10)
nums

## Method 1
for (i in c(1:10)){
  if(nums[i] == 66){
    print("太66666666666了")
    break
  }
  if(nums[i] > 50 && nums[i] %% 2 == 0){
    cat("偶數且大於50, value:", nums[i], "\n")
  }
  else{
    cat("都不符合", "\n")
  }
}

## Method 2
#for ( i in nums){
#  if(i == 66){
#    print("太66666666666了")
#    break
#  }
#  if(i > 50 && i %% 2 == 0){
#    cat("偶數且大於50, value:", i, "\n")
#  }
#  else{
#    cat("都不符合", "\n")
#  }
#}
