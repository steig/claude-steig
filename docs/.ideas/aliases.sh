#!/bin/bash
# Simone Efficiency Aliases - Source this file for ultra-fast commands
# Usage: source .ideas/aliases.sh

# Core Commands (Super Fast)
alias sp='/project:simone:prime'
alias sct='/project:simone:do_task_auto'
alias scm='/project:simone:create_milestone'
alias scp='/project:simone:create_pr_auto'
alias sy='/project:simone:yolo'
alias st='/project:simone:troubleshoot'
alias ss='/project:simone:status'

# Preset Combinations
alias speed-task='sct --persona-auto --quality-strict --bypass-approval --uc'
alias secure-task='sct --persona-security --persona-architect --quality-strict --consensus'
alias arch-task='sct --persona-architect --persona-performance --quality-strict --think-deep'
alias bug-task='sct --persona-qa --bypass-approval --quality-strict'

alias speed-pr='scp --auto-assign --ready-to-merge'
alias secure-pr='scp --persona-security --comprehensive --auto-assign'
alias arch-pr='scp --persona-architect --comprehensive'

# Sprint Operations
alias sprint-blitz='sy --balanced'
alias sprint-safe='sy --safe'
alias sprint-yolo='sy --yolo'

# Helper Functions
simone-speed() {
    if [ -z "$1" ]; then
        echo "Usage: simone-speed T01_S01"
        return 1
    fi
    sp && speed-task "$1" && speed-pr "$1"
}

simone-secure() {
    if [ -z "$1" ]; then
        echo "Usage: simone-secure T01_S01"
        return 1
    fi
    sp && secure-task "$1" && secure-pr "$1"
}

simone-new-feature() {
    if [ -z "$1" ]; then
        echo "Usage: simone-new-feature 'feature description'"
        return 1
    fi
    sp && scm "$1" && /project:simone:create_sprints_from_milestone && /project:simone:create_sprint_tasks
}

# Status helpers
alias simone-health='sp && ss && st'
alias simone-sync='/project:simone:sync_metadata'

echo "🚀 Simone efficiency aliases loaded!"
echo ""
echo "Quick commands:"
echo "  sp              - prime session"
echo "  speed-task T01  - fast automation"
echo "  speed-pr T01    - fast PR creation"
echo "  sprint-blitz S01 - autonomous sprint"
echo ""
echo "Workflows:"
echo "  simone-speed T01_S01           - complete task automation"
echo "  simone-secure T01_S01          - security-focused automation"  
echo "  simone-new-feature 'desc'      - full feature planning"
echo "  simone-health                  - check project status"