# Workflow Presets - Copy & Paste Efficiency

## Daily Development Presets

### 🚀 **Speed Preset** (for routine work)
```bash
/project:simone:prime
/project:simone:do_task_auto T01_S01 --persona-auto --quality-strict --bypass-approval --uc
/project:simone:create_pr_auto T01_S01 --auto-assign --ready-to-merge
```

### 🔒 **Security Preset** (for auth/sensitive features)
```bash
/project:simone:prime  
/project:simone:do_task_auto T01_S01 --persona-security --persona-architect --quality-strict --consensus
/project:simone:create_pr_auto T01_S01 --persona-security --comprehensive --auto-assign
```

### 🏗️ **Architecture Preset** (for system design)
```bash
/project:simone:prime
/project:simone:do_task_auto T01_S01 --persona-architect --persona-performance --quality-strict --think-deep
/project:simone:create_pr_auto T01_S01 --persona-architect --comprehensive
```

### 🐛 **Bug Fix Preset** (for quick fixes)
```bash
/project:simone:prime
/project:simone:do_task_auto T01_S01 --persona-qa --bypass-approval --quality-strict
/project:simone:create_pr_auto T01_S01 --ready-to-merge
```

## Sprint-Level Presets

### 🎯 **Sprint Blitz** (autonomous sprint execution)
```bash
/project:simone:prime
/project:simone:yolo S01 --balanced
```

### 📋 **Sprint Planning** (setup new sprint)
```bash
/project:simone:prime
/project:simone:create_milestone "feature description"
/project:simone:create_sprints_from_milestone
/project:simone:create_sprint_tasks
```

## Emergency Presets

### 🚨 **Hotfix Preset** 
```bash
/project:simone:prime
/project:simone:do_task_auto T01_S01 --persona-security --bypass-approval --quality-strict
/project:simone:create_pr_auto T01_S01 --ready-to-merge --auto-assign
```

### 🔧 **Debugging Preset**
```bash
/project:simone:prime
/project:simone:investigate "issue description"  
/project:simone:analyze "problematic code area"
/project:simone:troubleshoot
```

## Time-Boxed Workflows

### ⏱️ **5-Minute Feature** (small changes)
```bash
/project:simone:create_milestone "small feature"    # 30 sec
/project:simone:yolo S01 --balanced                 # 4.5 min
```

### ⏱️ **15-Minute Sprint** (medium features)
```bash
/project:simone:create_milestone "medium feature"   # 1 min
/project:simone:create_sprints_from_milestone        # 2 min  
/project:simone:yolo S01 --balanced                 # 12 min
```

### ⏱️ **1-Hour Epic** (large features)
```bash
/project:simone:create_milestone "large feature"    # 5 min
/project:simone:create_sprints_from_milestone        # 5 min
# Manual task breakdown                             # 10 min
/project:simone:yolo S01 --safe                     # 40 min
```

## Persona Combinations

### Full-Stack Development:
```bash
--persona-frontend --persona-backend --persona-qa
```

### Security-Critical:
```bash
--persona-security --persona-architect --persona-qa
```

### Performance Optimization:
```bash
--persona-performance --persona-architect --persona-analyzer
```

### Code Quality Focus:
```bash
--persona-qa --persona-refactorer --persona-mentor
```