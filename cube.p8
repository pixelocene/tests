pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--code from: http://labix.org/snippets/cube
function _init()
	originx=64
	originy=64
	cube={
		{-20,20,20},{20,20,20},
		{20,-20,20},{-20,-20,20},
		{-20,20,-20},{20,20,-20},
		{20,-20,-20},{-20,-20,-20},
	}
end

function _update()
	rotate(0.01,{0,1,0}) -- y
	rotate(0.01,{0,0,1}) -- x
	rotate(0.01,{1,0,0}) -- z
end

function _draw()
	cls(0)
	draw_cube()
end

function rotate(angle,axis)
	for i=1,#cube do
		cube[i]=rotate_point(cube[i],angle,axis)
	end
end

function rotate_point(point,angle,axis)
	ret={0,0,0}
	cosang=cos(angle)
	sinang=sin(angle)
	
	ret[1]+=(cosang+(1-cosang)*axis[1]*axis[1])*point[1]
 ret[1]+=((1-cosang)*axis[1]*axis[2]-axis[3]*sinang)*point[2]
 ret[1]+=((1-cosang)*axis[1]*axis[3]+axis[2]*sinang)*point[3]
 
 ret[2]+=((1-cosang)*axis[1]*axis[2]+axis[3]*sinang)*point[1]
 ret[2]+=(cosang+(1-cosang)*axis[2]*axis[2])*point[2]
 ret[2]+=((1-cosang)*axis[2]*axis[3]-axis[1]*sinang)*point[3]
 
 ret[3]+=((1-cosang)*axis[1]*axis[3]-axis[2]*sinang)*point[1]
 ret[3]+=((1-cosang)*axis[2]*axis[3]+axis[1]*sinang)*point[2]
 ret[3]+=(cosang+(1-cosang)*axis[3]*axis[3])*point[3]
	
	return ret
end

function draw_cube()
	a=cube[1]
	b=cube[2]
	c=cube[3]
	d=cube[4]
	e=cube[5]
	f=cube[6]
	g=cube[7]
	h=cube[8]
	draw_3dline(a,b)
	draw_3dline(b,c)
	draw_3dline(c,d)
	draw_3dline(d,a)
	draw_3dline(e,f)
	draw_3dline(f,g)
	draw_3dline(g,h)
	draw_3dline(h,e)
	draw_3dline(a,e)
	draw_3dline(b,f)
	draw_3dline(c,g)
	draw_3dline(d,h)
end

function draw_3dline(a,b)
	--drawing code is from
	--https://stackoverflow.com/questions/724219/how-to-convert-a-3d-point-into-2d-perspective-projection
	--haven't understood foc yet
	local foc=300
	ax=(a[1]*foc)/(a[3]+foc)+originx
	ay=(a[2]*foc)/(a[3]+foc)+originy
	bx=(b[1]*foc)/(b[3]+foc)+originy
	by=(b[2]*foc)/(b[3]+foc)+originy
 line(ax,ay,bx,by,7)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
