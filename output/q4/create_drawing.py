import math, json, html
from pathlib import Path

OUT=Path(__file__).parent
W,H=600,365
svg=[]; ents=[]; commands=[]
styles={
 'OUTLINE':('#182c42',7,.55,None),
 'CONSTRUCTION':('#9ba7b4',8,.22,'2 1.4'),
 'FOLD':('#527b96',4,.25,'3 1.2'),
 'CUT':('#be3c36',1,.65,None),
 'CENTER':('#7c8898',8,.23,'5 1 1 1'),
 'DIM':('#526174',7,.23,None),
 'TEXT':('#182c42',7,.2,None)}
def pairs(values):return ''.join(f'{k}\n{v}\n' for k,v in values)
def entity(kind,layer,values):ents.append(pairs([(0,kind),(8,layer)]+values))
def xy(p):return f'{p[0]:.7f},{p[1]:.7f}'
def layercmd(layer):commands.extend(['_.-LAYER','_Make',layer,''])
def line(a,b,layer='OUTLINE'):
 c,_,sw,dash=styles[layer]
 dashatt=f' stroke-dasharray="{dash}"' if dash else ''
 svg.append(f'<line x1="{a[0]}" y1="{H-a[1]}" x2="{b[0]}" y2="{H-b[1]}" stroke="{c}" stroke-width="{sw}"{dashatt}/>')
 entity('LINE',layer,[(10,a[0]),(20,a[1]),(30,0),(11,b[0]),(21,b[1]),(31,0)])
 layercmd(layer);commands.extend(['_.LINE',xy(a),xy(b),''])
def poly(points,layer='OUTLINE',closed=False):
 for a,b in zip(points,points[1:]):line(a,b,layer)
 if closed:line(points[-1],points[0],layer)
def shade(points):
 svg.append('<polygon points="'+' '.join(f'{x},{H-y}' for x,y in points)+'" fill="#eaf3f7" stroke="none"/>')
def text(p,s,size=3.4,anchor='middle',layer='TEXT'):
 svg.append(f'<text x="{p[0]}" y="{H-p[1]}" font-family="Arial, sans-serif" font-size="{size}" text-anchor="{anchor}" fill="{styles[layer][0]}">{html.escape(s)}</text>')
 s=s.replace('°',' deg').replace('×','x').replace('→','>').replace('−','-').replace('²','^2')
 values=[(10,p[0]),(20,p[1]),(30,0),(40,size),(1,s)]
 if anchor in ('middle','end'):values.extend([(72,1 if anchor=='middle' else 2),(11,p[0]),(21,p[1]),(31,0)])
 entity('TEXT',layer,values)
 layercmd(layer)
 if anchor=='middle':commands.extend(['_.-TEXT','_Justify','_Center',xy(p),str(size),'0',s])
 elif anchor=='end':commands.extend(['_.-TEXT','_Justify','_Right',xy(p),str(size),'0',s])
 else:commands.extend(['_.-TEXT',xy(p),str(size),'0',s])
def dot(p,layer='CUT',r=.7):
 svg.append(f'<circle cx="{p[0]}" cy="{H-p[1]}" r="{r}" fill="{styles[layer][0]}"/>')
 entity('CIRCLE',layer,[(10,p[0]),(20,p[1]),(30,0),(40,r)])
 layercmd(layer);commands.extend(['_.CIRCLE',xy(p),str(r)])
def arrow(p,d):
 x,y=p;dx,dy=d
 line(p,(x+2*dx-.65*dy,y+2*dy+.65*dx),'DIM')
 line(p,(x+2*dx+.65*dy,y+2*dy-.65*dx),'DIM')
def dim(a,b,offset,label,labeloffset=3):
 vx,vy=b[0]-a[0],b[1]-a[1];length=math.hypot(vx,vy);ux,uy=vx/length,vy/length;nx,ny=-uy,ux
 p=(a[0]+nx*offset,a[1]+ny*offset);q=(b[0]+nx*offset,b[1]+ny*offset)
 extra=2 if offset>=0 else -2
 line(a,(p[0]+nx*extra,p[1]+ny*extra),'DIM');line(b,(q[0]+nx*extra,q[1]+ny*extra),'DIM')
 line(p,q,'DIM');arrow(p,(ux,uy));arrow(q,(-ux,-uy))
 text(((p[0]+q[0])/2+nx*labeloffset,(p[1]+q[1])/2+ny*labeloffset),label,3.3)
def arc(center,r,start,end,layer='DIM'):
 pts=[(center[0]+r*math.cos(start+(end-start)*i/40),center[1]+r*math.sin(start+(end-start)*i/40)) for i in range(41)]
 poly(pts,layer)

L=math.hypot(140,60);alpha=2*math.asin(30/L)
base3=[(-60,0),(-30,-30*math.sqrt(3)),(30,-30*math.sqrt(3)),(60,0),(30,30*math.sqrt(3)),(-30,30*math.sqrt(3))]
cut3=[]
for x,y in base3[1:]:
 t=94/(140+x);cut3.append((t*x,t*y,140*(1-t)))
P=(-46,-14*math.sqrt(3),0);Q=(-46,14*math.sqrt(3),0)
O=(385,308)
def dev(i,r=L):
 a=(i-3)*alpha
 return (O[0]+r*math.sin(a),O[1]-r*math.cos(a))
V=[dev(i) for i in range(7)]
T=[dev(i,L*94/(140+base3[i][0])) for i in range(1,6)]
mix=lambda a,b,t:(a[0]+t*(b[0]-a[0]),a[1]+t*(b[1]-a[1]))
pd=mix(V[0],V[1],14/30);qd=mix(V[6],V[5],14/30)

text((16,351),'Q4  |  DEVELOPMENT OF A HEXAGONAL PYRAMID CUT BY AN AIP',5.5,'start')
text((16,341),'Base side 60 mm  |  Axis 140 mm  |  Cutting plane 45° to HP  |  Axis intercept 94 mm below apex',3.7,'start')
line((16,335),(583,335),'DIM')

# ELEVATION: assumed plan has opposite vertices A and D on a horizontal diagonal.
cx,by=82,174
fv=lambda p:(cx+p[0],by+p[2])
fvO=(cx,by+140)
ret=[fv(P),fv(cut3[2]),(cx+60,by)]
shade(ret)
for x in (-60,-30,30,60):line(fvO,(cx+x,by),'CONSTRUCTION')
line((cx-60,by),(cx-46,by),'CONSTRUCTION')
line((cx-46,by),(cx+60,by),'OUTLINE')
line((cx,by-4),(cx,by+144),'CENTER')
for i in (0,1,2):line(fv(cut3[i]),(cx+base3[i+1][0],by),'OUTLINE')
line(fv(P),fv(cut3[2]),'CUT')
line((cx-53,by-7),(cx+43,by+89),'CONSTRUCTION')
for p in [P]+cut3[:3]:dot(fv(p))
text((cx,by+146),"O'",4)
for x,s in [(-60,"A'"),(-30,"B', F'"),(0,"axis"),(30,"C', E'"),(60,"D'")]:text((cx+x,by-7),s,3)
text((cx-46-2,by+4),"P', Q'",3.2,anchor='end',layer='CUT')
text((fv(cut3[0])[0]-5,fv(cut3[0])[1]+4),"1', 5'",3.2,'end',layer='CUT')
text((fv(cut3[1])[0]-5,fv(cut3[1])[1]+4),"2', 4'",3.2,'end',layer='CUT')
text((fv(cut3[2])[0]+3,fv(cut3[2])[1]+3),"3'",3.2,'start',layer='CUT')
dot((cx,by+46));text((cx-4,by+47),"K'",3.1,'end',layer='CUT')
dim((cx,by),(cx,by+140),-75,'140',-6)
dim((cx,by+46),(cx,by+140),-89,'94',-6)
dim((cx,by),(cx,by+46),-89,'46',-6)
line(fv(P),(cx-11,by),'DIM')
arc(fv(P),17,0,math.pi/4);text((cx-24,by+8),'45°',3.4)
text((82,153),'FRONT ELEVATION',4.2)

# TOP VIEW with section polygon and retained base side.
pc=(82,80)
plan=lambda p:(pc[0]+p[0],pc[1]+p[1])
planbase=[plan(p) for p in base3]
shade([plan(P)]+planbase[1:]+[plan(Q)])
poly(planbase,'CONSTRUCTION',True)
poly([plan(P)]+planbase[1:]+[plan(Q)],'OUTLINE')
for p in planbase:line(pc,p,'CONSTRUCTION')
poly([plan(P)]+[plan(p) for p in cut3]+[plan(Q)],'CUT',True)
line((pc[0]-64,pc[1]),(pc[0]+64,pc[1]),'CENTER')
for i,(x,y) in enumerate(planbase):
 off=[(-5,0),(-3,-6),(3,-6),(5,0),(3,4),(-3,4)][i]
 text((x+off[0],y+off[1]),'ABCDEF'[i],3.5)
text((pc[0]+3,pc[1]-5),'o',3.3,'start')
for i,p in enumerate(cut3):
 q=plan(p);dot(q)
 off=[(-5,-3),(2,-6),(4,-2),(2,3),(-5,2)][i]
 text((q[0]+off[0],q[1]+off[1]),str(i+1),3.2,layer='CUT')
for label,p in [('P',P),('Q',Q)]:
 q=plan(p);dot(q);text((q[0]-5,q[1]),label,3.3,layer='CUT')
dim(planbase[1],planbase[2],-11,'60',-3)
text((82,7),'TOP VIEW  |  A–D parallel to XY',3.5)

# RADIAL DEVELOPMENT: pale blue is the lower retained lateral surface.
shade([pd]+V[1:6]+[qd]+list(reversed(T)))
for v in V:line(O,v,'CONSTRUCTION')
poly(V,'CONSTRUCTION')
poly([pd]+V[1:6]+[qd],'OUTLINE')
poly([pd]+T+[qd],'CUT')
for i in range(1,6):line(T[i-1],V[i],'FOLD')
dot(O,'OUTLINE');text((O[0],O[1]+6),'O',4.3)
for i,v in enumerate(V):
 u=((v[0]-O[0])/L,(v[1]-O[1])/L)
 text((v[0]+8*u[0],v[1]+8*u[1]-1),'ABCDEF A'.replace(' ','')[i],3.8)
for i,p in enumerate(T):
 dot(p);u=((p[0]-O[0])/math.dist(p,O),(p[1]-O[1])/math.dist(p,O))
 text((p[0]-7*u[0],p[1]-7*u[1]),str(i+1),3.7,layer='CUT')
for label,p,off in [('P',pd,(-6,2)),('Q',qd,(6,2))]:dot(p);text((p[0]+off[0],p[1]+off[1]),label,3.7,layer='CUT')
text((385,324),'RADIAL-LINE DEVELOPMENT',4.5)
text((385,131),'Retain the lower outlined region  |  Red line = cut boundary P–1–2–3–4–5–Q',3.5)
text((385,124),'Grey dashed lines reconstruct the complete pyramid. Seam: OA.',3.3)
dim(V[2],V[3],-13,'60',-4)
arc(O,24,-math.pi/2-alpha,-math.pi/2)
text((O[0]-10,O[1]-33),'22.718°',3.4)
line(mix(O,V[0],.52),(267,291),'DIM');text((246,298),'True edge OA = 152.315',3.3,'start')
line(pd,(240,197),'DIM');text((224,191),'AP = 28',3.2,'start')
line(qd,(531,197),'DIM');text((529,191),'AQ = 28',3.2,'start')

# CALCULATIONS and true-length transfer table.
text((215,111),'TRUE LENGTHS / AUTOCAD CONSTRUCTION',4,'start')
rows=[
 '1. Slant edge L = sqrt(140² + 60²) = 152.315 mm.',
 '2. Draw six triangles with sides L, L, 60; angle at O = 22.718447° each.',
 '3. From O, mark the following true distances on the developed generators:',
]
for i,s in enumerate(rows):text((215,103-i*7),s,3.4,'start')
table=[('Generator','OB / OF','OC / OE','OD'),('Cut point','1 / 5','2 / 4','3'),('Distance from O','130.160','84.221','71.588')]
xs=[215,345,426,503]
for j,row in enumerate(table):
 for x,s in zip(xs,row):text((x,79-j*7),s,3.4,'start')
line((215,82),(566,82),'DIM');line((215,61),(566,61),'DIM')
notes=[
 '4. On the two end base edges, mark AP = AQ = 28 mm from A.',
 '5. Join P–1–2–3–4–5–Q with STRAIGHT lines; retain the lower outlined region.',
 'Plane: z = 46 + x. For an edge with base coordinate xb: Oi = L × 94/(140 + xb).',
 'Important: the plane misses OA and meets base edges AB and AF.',
 'A full six-edge truncated-pyramid outline would be incorrect for these dimensions.',
 'All dimensions in mm. Orientation shown: base vertices A and D at x = −60 and +60.'
]
for i,s in enumerate(notes):text((215,53-i*7),s,3.25,'start')

body=''.join(svg)
def document(square=False):
 return f'<svg xmlns="http://www.w3.org/2000/svg" width="2400" height="{2400 if square else 1460}" viewBox="0 0 {W} {W if square else H}"><rect width="100%" height="100%" fill="white"/>{body}</svg>'
(OUT/'Q4_labelled_solution.svg').write_text(document())
(OUT/'Q4_preview.svg').write_text(document(True))

head=pairs([(0,'SECTION'),(2,'HEADER'),(9,'$ACADVER'),(1,'AC1009'),(9,'$MEASUREMENT'),(70,1),(0,'ENDSEC'),(0,'SECTION'),(2,'TABLES'),(0,'TABLE'),(2,'LTYPE'),(70,3)])
for name,pattern in [('CONTINUOUS',[]),('DASHED',[3,-1.5]),('CENTER',[5,-1,1,-1])]:
 head+=pairs([(0,'LTYPE'),(2,name),(70,0),(3,name),(72,65),(73,len(pattern)),(40,sum(abs(v) for v in pattern))]+[(49,v) for v in pattern])
head+=pairs([(0,'ENDTAB'),(0,'TABLE'),(2,'LAYER'),(70,len(styles))])
for name,(_,color,_,dash) in styles.items():
 head+=pairs([(0,'LAYER'),(2,name),(70,0),(62,color),(6,'CENTER' if name=='CENTER' else 'DASHED' if dash else 'CONTINUOUS')])
head+=pairs([(0,'ENDTAB'),(0,'ENDSEC'),(0,'SECTION'),(2,'ENTITIES')])
dxf=head+''.join(ents)+pairs([(0,'ENDSEC'),(0,'EOF')])
dxf=dxf.replace('–','-')
(OUT/'Q4_labelled_solution.dxf').write_text(dxf,encoding='ascii')
cmd=['_.UCS','_World','_.OSMODE','0','_.DYNMODE','0','_.TEXTSIZE','3.4']
for name,(_,color,_,_) in styles.items():cmd+=['_.-LAYER','_Make',name,'_Color',str(color),name,'']
cmd+=commands+['_.ZOOM','_Extents','']
(OUT/'Q4_labelled_solution.scr').write_text('\n'.join(cmd).replace('–','-'),encoding='ascii')
data={'slant_edge':L,'panel_angle_degrees':math.degrees(alpha),'section_points_3d':[P]+cut3+[Q], 'developed_base_vertices':V,'developed_cut_points':[pd]+T+[qd]}
(OUT/'geometry.json').write_text(json.dumps(data,indent=2))
# Verify cylinder-free planar section geometry and the development's true lengths.
for x,y,z in [P]+cut3+[Q]:assert abs(z-(46+x))<1e-9
for i in range(6):assert abs(math.dist(V[i],V[i+1])-60)<1e-9
for i in range(1,6):assert abs(math.dist(O,T[i-1])-math.dist((0,0,140),cut3[i-1]))<1e-9
source=[P]+cut3+[Q];flat=[pd]+T+[qd]
for i in range(6):assert abs(math.dist(source[i],source[i+1])-math.dist(flat[i],flat[i+1]))<1e-9
assert abs(math.dist(pd,V[0])-28)<1e-9
assert abs(math.dist(qd,V[6])-28)<1e-9
print('Validated section plane, all panel sides, true generator distances, and all six cut segments.')
print('Outputs:',OUT)
