pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
	fws={}
end

function _update()
	-- delete fireworks if finished
	for i=#fws,1,-1 do
		if fws[i].finished() then
			deli(fws,i)
		end
	end
	-- start new firework
	if btnp(❎) then
		local fw=fwk.new()
		fw.explode()
		add(fws,fw)
	end
	-- make firework alive
	for fw in all(fws) do
		fw.update()
	end
end

function _draw()
	cls()
	for fw in all(fws) do
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
			for i=1,60 do
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
			local finished=true
			for ptcl in all(self.ptcls) do
				if not ptcl.dead() then
					finished=false
				end
			end
			return finished
		end
		
		-- update the firework/particles
		function self.update()
			for i=#self.ptcls,1,-1 do
				local ptcl=self.ptcls[i]
				ptcl.update()
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
			ox=nil,
			oy=nil,
			x=nil,
			y=nil,
			dx=0,
			dy=0,
			sp=3,
			ang=nil,
			col=nil,
			age=0,
			mage=0,
			trail={}
		}
		
		-- origin coords
		self.ox=_x
		self.oy=_y
		-- end of acceleration coords
		self.ex=_x
		self.ey=_y
		-- current coord
		self.x=_x
		self.y=_y
		-- movement
		self.ang=rnd(365)
		self.dx=sin(self.ang)
		self.dy=cos(self.ang)
		-- color
		self.col=_col
		-- maximum age of the particle
		self.mage=10+ceil(rnd(20))
		
		-- update particle position
		function self.update()
		
			local col=self.col
			if self.isdying() then
				col=5
			end
			
			-- add a particle in the trail
			add(
				self.trail,
				fwpctltrail.new(
					self.x,
					self.y,
					self.age+1,
					self.mage/2,
					col
				)
			)
		
			self.sp=mid(
				0.4,
				self.sp-0.2,
				self.sp
			)
			self.x+=self.dx*self.sp
			if self.sp <= 0.6 then
				self.dy=mid(
					0.5,
					self.dy+0.2,
					self.dy
				)
			end

			self.y+=self.dy*self.sp
			self.age+=1
			
			for t in all(self.trail) do
				t.update()
			end
			
			-- remove all dead trail
			for i=#self.trail,1,-1 do
				if self.trail[i].isdead() then
					deli(self.trail,i)
				end
			end
		end
		
		-- check if the particle
		-- reached end of life
		function self.dead()
			return self.age>self.mage
		end
		
		-- draw the particle on screen
		function self.draw()
			-- draw the trail
			for i,t in ipairs(self.trail) do
				local nxt=nil
				if i<#self.trail then
					nxt=self.trail[i+1]
				end
				t.draw(nxt)
			end
			-- draw ending pixel
			local col=self.col
			if self.isdying() then
				col=5
			end
			pset(self.x,self.y,col)
		end
		
		function self.isdying()
			return self.age/self.mage>0.8
		end
		
		return self
	end
		
}

-- fireworks particles trail

fwpctltrail={
	new=function(_x,_y,_age,_mage,_col)
		local self={
			x=_x,
			y=_y,
			age=0,
			mage=3,
			col=_col,
		}
		
		function self.isdead()
			return self.age>=self.mage
		end
		
		function self.update()
			self.age+=rnd(1)
		end
		
		function self.draw(_nxt)
			if _nxt~=nil then
				line(
					self.x,
					self.y,
					_nxt.x,
					_nxt.y,
					self.col
				)
			end
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
