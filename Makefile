# <target>: <prerequisites>
# <tab> <commands>

clean:
	rm *.o
	rm *.txt

txt = Hello World
test:
	@echo $(txt)
	echo $$HOME

result.txt: source.txt 
	cp source.txt result.txt

source.txt:
	echo "This is the source" > source.txt

multi.txt: s1.txt s2.txt s3.txt

s1.txt:
	echo "S1" > s1.o

s2.txt:
	echo "S2" > s2.txt

s3.txt:
	echo "S3" > s3.txt

# 每行命令都是在一个单独的shell中执行, 下面取不到foo的值
var-lost:
	export foo=bar
	echo "foo=[$$foo]" 
	
# 一种解决办法就是将两行命令写在同一行，中间用分号间隔
var-kept:
	export foo=bar; echo "foo=[$$foo]"

# solution 2, 在换行前加反斜杠转义
var-kept2:
	export foo=bar;\
		echo "foo=[$$foo]"

# solution 3, .ONESHELL: 命令


# 回声（echoinga）, make 会打印每条执行的命令
echoing:
		# echoing

# 在命令前添加@就可以关闭回声
# 由于在构建过程中，需要了解当前在执行哪条命令，所以通常只在注释和纯显示的echo命令前面加上@
no-echoing:
		@# echoing
		@echo TODO

# 自动变量
# $@ 代指当前目标
foo.txt:
	touch $@

# $< 代指第一个前置条件

# phony target, target will  execute after make call every time
.PHONY:	clean
