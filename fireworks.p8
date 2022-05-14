pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
	fw=nil
end

function _update()
	-- delete fireworks if finished
	if fw~=nil and fw.finished() then
		fw=nil
	end
	-- start new firework
	if btnp(❎) then
		fw=fwk.new()
		fw.explode()
	end
	-- make firework alive
	if fw~=nil then
		fw.update()
	end
end

function _draw()
	cls()
	if fw~=nil then
		fw.draw()
	end
end
-->8
-- fireworks

fwk={
	new=function(_x,_y)
		local colors={10,12,14}
		local self={
			x=nil,
			y=nil,
			col=colors[ceil(rnd(#colors))],
			ptcls={}
		}
		
		self.x=_x or ceil(rnd(128))
		self.y=_y or ceil(rnd(128))
		
		-- make firework explode
		-- and generate particles
		function self.explode()
			for i=1,50 do
				add(
					self.ptcls,
					fwptcl.new(
						self.x,
						self.y,
						self.col
					)
				)
			end
		end
		
		-- check if the firework has
		-- finished
		function self.finished()
			return #self.ptcls==0
		end
		
		-- update the firework/particles
		function self.update()
			for i=#self.ptcls,1,-1 do
				local ptcl=self.ptcls[i]
				ptcl.update()
				if ptcl:dead() then
					deli(self.ptcls,i)
				end
			end
		end
		
		-- draw the firework
		function self.draw()
			for ptcl in all(self.ptcls) do
				ptcl.draw()
			end
		end
		
		return self
	end
}

-- fireworks particles

fwptcl={
	new=function(_x,_y,_col)
		local self={
			x=nil,
			y=nil,
			dx=0,
			dy=0,
			sp=3,
			ang=nil,
			col=nil,
			age=0,
			mage=0
		}
		
		self.x=_x
		self.y=_y
		self.ang=rnd(365)
		self.dx=sin(self.ang)
		self.dy=cos(self.ang)
		self.col=_col
		self.mage=30+ceil(rnd(40))
		
		-- update particle position
		function self.update()
			self.sp=mid(
				0.4,
				self.sp-0.2,
				self.sp
			)
			self.x+=self.dx*self.sp
			if self.sp <= 0.6 then
				self.dy=mid(
					3,
					self.dy+0.2,
					self.dy
				)
			end
			self.y+=self.dy*self.sp
			self.age+=1
		end
		
		-- check if the particle
		-- reached end of life
		function self.dead()
			return self.age>self.mage
		end
		
		-- draw the particle on screen
		function self.draw()
			pset(self.x,self.y,self.col)
		end
		
		return self
	end
		
}
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
