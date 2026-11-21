import math
from pathlib import Path

OUT=Path(__file__).parent
W,H=390,225
svg=[]; entities=[]
colors={'OUTLINE':'#172536','HOLE':'#006f91','FOLD':'#64748b','CENTER':'#8494a5','DIM':'#46566a','TEXT':'#172536'}
def pair(c,v): return f'{c}\n{v}\n'
def ent(kind,layer,vals):
    entities.append(pair(0,kind)+pair(8,layer)+''.join(pair(c,v) for c,v in vals))
def line(x1,y1,x2,y2,layer='OUTLINE'):
    dash=' stroke-dasharray="2.5 1.4"' if layer in ('FOLD','CENTER') else ''
    svg.append(f'<line x1="{x1}" y1="{H-y1}" x2="{x2}" y2="{H-y2}" stroke="{colors[layer]}" stroke-width="{0.5 if layer in ("OUTLINE","HOLE") else 0.22}"{dash}/>')
    ent('LINE',layer,[(10,x1),(20,y1),(30,0),(11,x2),(21,y2),(31,0)])
def text(x,y,s,size=3.1,anchor='middle',layer='TEXT'):
    svg.append(f'<text x="{x}" y="{H-y}" fill="{colors[layer]}" font-family="Arial, sans-serif" font-size="{size}" text-anchor="{anchor}">{s}</text>')
    # Align centered DXF text using its alignment point.
    vals=[(10,x),(20,y),(30,0),(40,size),(1,s.replace('Ø','%%c'))]
    if anchor=='middle': vals += [(72,1),(11,x),(21,y),(31,0)]
    ent('TEXT',layer,vals)
def ellipse(cx,cy,rx,ry,layer='HOLE'):
    svg.append(f'<ellipse cx="{cx}" cy="{H-cy}" rx="{rx}" ry="{ry}" fill="none" stroke="{colors[layer]}" stroke-width="0.5"/>')
    # Closed 720-segment polyline, max chord error below 0.0003 mm.
    ent('POLYLINE',layer,[(66,1),(10,0),(20,0),(30,0),(70,1)])
    for n in range(720):
        t=n*2*math.pi/720
        ent('VERTEX',layer,[(10,cx+rx*math.cos(t)),(20,cy+ry*math.sin(t)),(30,0),(70,0)])
    ent('SEQEND',layer,[])
def rect(x,y,w,h):
    for a,b in [((x,y),(x+w,y)),((x+w,y),(x+w,y+h)),((x+w,y+h),(x,y+h)),((x,y+h),(x,y))]:line(*a,*b)
def arrow(x,y,dx,dy):
    line(x,y,x+dx*1.5-dy*.5,y+dy*1.5+dx*.5,'DIM')
    line(x,y,x+dx*1.5+dy*.5,y+dy*1.5-dx*.5,'DIM')
def hdim(x1,x2,y,ref,label):
    for x in (x1,x2):line(x,ref,x,y+2,'DIM')
    line(x1,y,x2,y,'DIM');arrow(x1,y,1,0);arrow(x2,y,-1,0);text((x1+x2)/2,y+1.8,label,2.8)
def vdim(x,y1,y2,ref,label):
    for y in (y1,y2):line(ref,y,x+2,y,'DIM')
    line(x,y1,x,y2,'DIM');arrow(x,y1,0,1);arrow(x,y2,0,-1);text(x+2.5,(y1+y2)/2,label,2.8,'start')

text(15,214,'Q3  |  DEVELOPMENT OF A SQUARE PRISM WITH A HORIZONTAL HOLE',4.6,'start')
text(15,207,'All dimensions in mm  •  Square base 50  •  Height 70  •  Hole Ø40  •  Axis height 35',3.1,'start')
# Front elevation; hole axis perpendicular to the elevation plane.
a=50/math.sqrt(2); fx=53; base=115
rect(fx-a,base,2*a,70)
line(fx,base,fx,base+15);line(fx,base+55,fx,base+70)
ellipse(fx,base+35,20,20)
line(fx-25,base+35,fx+25,base+35,'CENTER');line(fx,base+10,fx,base+60,'CENTER')
vdim(98,base,base+70,fx+a,'70')
vdim(9,base,base+35,fx-a,'35')
line(fx+14.14,base+49.14,fx+27,base+62,'DIM');text(fx+28,base+63,'Ø40',3,'start')
text(fx,106,'FRONT ELEVATION',3.5)
# Plan A(left), B(front), C(right), D(back).
py=61
pts=[(fx-a,py),(fx,py-a),(fx+a,py),(fx,py+a)]
for i in range(4):line(*pts[i],*pts[(i+1)%4])
for x in (-20,20):line(fx+x,py-(a-abs(x)),fx+x,py+(a-abs(x)),'FOLD')
line(fx,py-a-3,fx,py+a+3,'CENTER')
for (x,y),label,dx,dy in zip(pts,'ABCD',[-4,0,4,0],[0,-5,0,3]):text(x+dx,y+dy,label)
text(79,33,'Side = 50',3,'start');text(fx,13,'TOP VIEW',3.5)
# Unfold at A: face order AB, BC, CD, DA.
dx=135;dy=115
rect(dx,dy,200,70)
for u in (50,100,150):
    if u in (50,150):
        line(dx+u,dy,dx+u,dy+15,'FOLD');line(dx+u,dy+55,dx+u,dy+70,'FOLD')
    else:line(dx+u,dy,dx+u,dy+70,'FOLD')
for u in (50,150):
    ellipse(dx+u,dy+35,20*math.sqrt(2),20)
    line(dx+u-32,dy+35,dx+u+32,dy+35,'CENTER')
    line(dx+u,dy+11,dx+u,dy+59,'CENTER')
for i,c in enumerate('ABCDA'):text(dx+50*i,dy-5,c)
for i,c in enumerate(['FACE AB','FACE BC','FACE CD','FACE DA']):text(dx+25+50*i,dy+63,c,2.8)
for i in range(4):hdim(dx+i*50,dx+(i+1)*50,192,185,'50')
hdim(dx,dx+200,101,115,'200 = 4 × 50')
vdim(343,dy,dy+70,335,'70')
hdim(dx+50-20*math.sqrt(2),dx+50+20*math.sqrt(2),139,150,'56.57')
vdim(322,dy+15,dy+55,dx+150,'40')
text(235,91,'LATERAL SURFACE DEVELOPMENT  |  Seam at A',3.6)
text(135,78,'CONSTRUCTION / AUTOCAD',3.7,'start')
notes=[
'1. Draw a 200 × 70 rectangle; divide it into four 50 mm panels.',
'2. Use the bottom-left corner as (0, 0). Fold lines: x = 50, 100, 150.',
'3. Opening centres: (50, 35) and (150, 35).',
'4. ELLIPSE → Center: horizontal semi-axis 28.2843; vertical semi-axis 20.',
'5. Trim the fold lines at B and D between heights 15 and 55.',
'The two openings straddle B and D; their interiors are removed.',
'True developed width = 40 / cos 45° = 56.5685 mm.',
'Unfolded opening: (x − xc)² / 800 + (y − 35)² / 400 = 1.'
]
for i,s in enumerate(notes):text(135,70-i*6.5,s,2.9,'start')
svgtext=f'<svg xmlns="http://www.w3.org/2000/svg" width="1560" height="900" viewBox="0 0 {W} {H}"><rect width="100%" height="100%" fill="white"/>'+''.join(svg)+'</svg>'
(OUT/'Q3_solution.svg').write_text(svgtext)
header='0\nSECTION\n2\nHEADER\n9\n$ACADVER\n1\nAC1009\n0\nENDSEC\n0\nSECTION\n2\nTABLES\n0\nTABLE\n2\nLAYER\n70\n6\n'
for i,name in enumerate(colors):header+=f'0\nLAYER\n2\n{name}\n70\n0\n62\n{[7,4,8,8,7,7][i]}\n6\nCONTINUOUS\n'
header+='0\nENDTAB\n0\nENDSEC\n0\nSECTION\n2\nENTITIES\n'
# Use ASCII-safe annotation for broad DXF compatibility.
dxf=header+''.join(entities)+'0\nENDSEC\n0\nEOF\n'
for old,new in [('•','|'),('×','x'),('→','>'),('−','-'),('²','^2'),('°',' deg')]:dxf=dxf.replace(old,new)
(OUT/'Q3_solution.dxf').write_text(dxf,encoding='ascii')
script=['_.UCS','_World','_.OSMODE','0','_.RECTANG','0,0','200,70']
for x,lo,hi in [(50,0,15),(50,55,70),(100,0,70),(150,0,15),(150,55,70)]:
    script+=['_.LINE',f'{x},{lo}',f'{x},{hi}','']
for x in (50,150):script+=['_.ELLIPSE','_Center',f'{x},35',f'{x+20*math.sqrt(2):.10f},35','20']
script+=['_.ZOOM','_Extents','']
(OUT/'Q3_exact_development.scr').write_text('\n'.join(script))
assert abs(2*20*math.sqrt(2)-56.5685424949)<1e-8
print('Created SVG, DXF and exact AutoCAD script in', OUT)
