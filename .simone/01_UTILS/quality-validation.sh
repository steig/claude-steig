#!/usr/bin/env bash
# Quality Validation System - Prevent lazy usage and enforce "garbage in, garbage out"
# Core validation functions for Simone Framework

set -euo pipefail

# Quality scoring thresholds
readonly MIN_DESCRIPTION_WORDS=10
readonly MIN_TITLE_WORDS=3
readonly MIN_ACCEPTANCE_CRITERIA_WORDS=15
readonly QUALITY_SCORE_THRESHOLD=7  # Out of 10

# ANSI color codes for output
readonly RED='\033[0;31m'
readonly YELLOW='\033[1;33m'
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Function to count meaningful words (excluding common filler words)
count_meaningful_words() {
    local text="$1"
    
    # Remove common filler words and count remaining
    echo "$text" | tr '[:upper:]' '[:lower:]' | \
    sed -e 's/\b\(the\|a\|an\|and\|or\|but\|in\|on\|at\|to\|for\|of\|with\|by\|this\|that\|these\|those\|is\|are\|was\|were\|be\|been\|being\|have\|has\|had\|do\|does\|did\|will\|would\|should\|could\|may\|might\|must\)\b//g' | \
    wc -w | tr -d ' '
}

# Function to calculate quality score for text input
calculate_quality_score() {
    local text="$1"
    local min_words="$2"
    local text_type="$3"
    
    local word_count
    word_count=$(count_meaningful_words "$text")
    local score=0
    
    # Word count scoring (0-4 points)
    if [[ $word_count -ge $((min_words * 2)) ]]; then
        score=$((score + 4))
    elif [[ $word_count -ge $((min_words + min_words/2)) ]]; then
        score=$((score + 3))
    elif [[ $word_count -ge $min_words ]]; then
        score=$((score + 2))
    elif [[ $word_count -ge $((min_words/2)) ]]; then
        score=$((score + 1))
    fi
    
    # Specificity scoring (0-3 points)
    local specificity_score=0
    if echo "$text" | grep -qE '\b(will|shall|must|should)\b'; then
        specificity_score=$((specificity_score + 1))
    fi
    if echo "$text" | grep -qE '\b(when|if|given|then)\b'; then
        specificity_score=$((specificity_score + 1))
    fi
    if echo "$text" | grep -qE '\b(user|system|application|feature|requirement)\b'; then
        specificity_score=$((specificity_score + 1))
    fi
    score=$((score + specificity_score))
    
    # Structure scoring (0-3 points)
    local structure_score=0
    if echo "$text" | grep -qE '^\s*-|\*|[0-9]+\.'; then
        structure_score=$((structure_score + 1))  # Has bullet points or numbers
    fi
    if echo "$text" | grep -qE '\?'; then
        structure_score=$((structure_score + 1))  # Has questions (shows thinking)
    fi
    if [[ ${#text} -gt 100 ]]; then
        structure_score=$((structure_score + 1))  # Sufficient length
    fi
    score=$((score + structure_score))
    
    echo "$score"
}

# Function to validate input quality with detailed feedback
validate_input_quality() {
    local text="$1"
    local min_words="$2"
    local text_type="$3"
    local allow_warnings="${4:-true}"
    
    local word_count
    word_count=$(count_meaningful_words "$text")
    
    local quality_score
    quality_score=$(calculate_quality_score "$text" "$min_words" "$text_type")
    
    echo -e "${BLUE}📊 Quality Analysis for $text_type:${NC}"
    echo -e "   Words: $word_count (minimum: $min_words)"
    echo -e "   Quality Score: $quality_score/10"
    echo
    
    # Check for obvious lazy patterns
    local lazy_patterns=(
        "TBD" "TODO" "fix this" "update this" "change this"
        "as needed" "if needed" "might need" "probably should"
        "stuff" "things" "etc" "and so on"
    )
    
    local lazy_found=false
    for pattern in "${lazy_patterns[@]}"; do
        if echo "$text" | grep -qi "$pattern"; then
            echo -e "${RED}❌ LAZY PATTERN DETECTED: '$pattern'${NC}"
            lazy_found=true
        fi
    done
    
    # Quality gate decisions
    if [[ $lazy_found == true ]]; then
        echo -e "${RED}🚫 BLOCKED: Lazy patterns detected. Please provide specific, actionable content.${NC}"
        return 1
    elif [[ $word_count -lt $min_words ]]; then
        echo -e "${RED}🚫 BLOCKED: Insufficient detail. Need at least $min_words meaningful words.${NC}"
        return 1
    elif [[ $quality_score -lt $QUALITY_SCORE_THRESHOLD ]]; then
        if [[ $allow_warnings == "true" ]]; then
            echo -e "${YELLOW}⚠️  WARNING: Low quality score. Consider adding:${NC}"
            echo -e "   • More specific details and requirements"
            echo -e "   • Clear acceptance criteria or success metrics"
            echo -e "   • Structured format (bullet points, numbered lists)"
            echo -e "   • Action-oriented language (will, must, should)"
            echo
            read -p "Continue anyway? (y/N): " -r
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                echo -e "${RED}🚫 Cancelled by user. Please improve input quality.${NC}"
                return 1
            fi
        else
            echo -e "${RED}🚫 BLOCKED: Quality score too low for automated execution.${NC}"
            return 1
        fi
    else
        echo -e "${GREEN}✅ Quality validation passed!${NC}"
    fi
    
    return 0
}

# Function to validate project manifest quality
validate_project_manifest() {
    local manifest_file=".simone/00_PROJECT_MANIFEST.md"
    
    if [[ ! -f "$manifest_file" ]]; then
        echo -e "${RED}❌ Project manifest not found: $manifest_file${NC}"
        return 1
    fi
    
    echo -e "${BLUE}🔍 Validating project manifest quality...${NC}"
    
    # Extract description section
    local description
    description=$(sed -n '/### Description/,/###/p' "$manifest_file" | head -n -1 | tail -n +2 | tr '\n' ' ')
    
    if [[ -z "$description" || "$description" =~ ^\[.*\]$ ]]; then
        echo -e "${RED}🚫 BLOCKED: Project description is empty or placeholder text.${NC}"
        echo -e "   Edit $manifest_file and provide a detailed project description."
        return 1
    fi
    
    if ! validate_input_quality "$description" $MIN_DESCRIPTION_WORDS "Project Description" false; then
        echo -e "${RED}🚫 BLOCKED: Project manifest quality insufficient for task execution.${NC}"
        echo -e "   Please improve the project description in $manifest_file"
        return 1
    fi
    
    echo -e "${GREEN}✅ Project manifest validation passed!${NC}"
    return 0
}

# Function to enforce progressive restrictions based on project history
check_project_quality_history() {
    local quality_log=".simone/.cache/quality-history.log"
    
    # Create quality history if it doesn't exist
    if [[ ! -f "$quality_log" ]]; then
        mkdir -p ".simone/.cache"
        echo "# Quality History Log - Tracks input quality over time" > "$quality_log"
        echo "# Format: timestamp|action|quality_score|word_count" >> "$quality_log"
        return 0
    fi
    
    # Count recent low-quality submissions (last 10 entries)
    local recent_low_quality
    recent_low_quality=$(tail -n 10 "$quality_log" | grep -v '^#' | awk -F'|' '$3 < 7' | wc -l | tr -d ' ')
    
    if [[ $recent_low_quality -ge 3 ]]; then
        echo -e "${YELLOW}⚠️  QUALITY ALERT: Multiple recent low-quality inputs detected.${NC}"
        echo -e "   Consider taking a break to plan more thoroughly."
        echo -e "   Recent low-quality submissions: $recent_low_quality/10"
        echo
        
        # Implement cooling-off period for repeated low quality
        if [[ $recent_low_quality -ge 5 ]]; then
            echo -e "${RED}🚫 COOLING-OFF PERIOD: Too many low-quality inputs.${NC}"
            echo -e "   Please review project requirements and plan more carefully."
            echo -e "   Wait 30 minutes or improve 3 existing items before creating new ones."
            return 1
        fi
    fi
    
    return 0
}

# Function to log quality metrics for tracking
log_quality_metrics() {
    local action="$1"
    local quality_score="$2"
    local word_count="$3"
    local quality_log=".simone/.cache/quality-history.log"
    
    mkdir -p ".simone/.cache"
    echo "$(date '+%Y-%m-%d %H:%M:%S')|$action|$quality_score|$word_count" >> "$quality_log"
}

# Function to generate quality report
generate_quality_report() {
    local quality_log=".simone/.cache/quality-history.log"
    
    if [[ ! -f "$quality_log" ]]; then
        echo -e "${YELLOW}No quality history found.${NC}"
        return 0
    fi
    
    echo -e "${BLUE}📊 Project Quality Report${NC}"
    echo "========================="
    echo
    
    local total_entries
    total_entries=$(grep -v '^#' "$quality_log" | wc -l | tr -d ' ')
    
    if [[ $total_entries -eq 0 ]]; then
        echo "No quality data available yet."
        return 0
    fi
    
    local avg_quality
    avg_quality=$(grep -v '^#' "$quality_log" | awk -F'|' '{sum+=$3} END {printf "%.1f", sum/NR}')
    
    local low_quality_count
    low_quality_count=$(grep -v '^#' "$quality_log" | awk -F'|' '$3 < 7' | wc -l | tr -d ' ')
    
    local high_quality_count
    high_quality_count=$(grep -v '^#' "$quality_log" | awk -F'|' '$3 >= 8' | wc -l | tr -d ' ')
    
    echo "Total submissions: $total_entries"
    echo "Average quality score: $avg_quality/10"
    echo "High quality (8+): $high_quality_count ($((high_quality_count * 100 / total_entries))%)"
    echo "Low quality (<7): $low_quality_count ($((low_quality_count * 100 / total_entries))%)"
    echo
    
    if [[ $low_quality_count -gt $((total_entries / 3)) ]]; then
        echo -e "${YELLOW}⚠️  Consider improving input quality for better project outcomes.${NC}"
    elif [[ $high_quality_count -gt $((total_entries * 2 / 3)) ]]; then
        echo -e "${GREEN}🎉 Excellent quality standards! Keep up the good work.${NC}"
    fi
}

# Function to validate task creation inputs
validate_task_creation() {
    local title="$1"
    local description="$2"
    local acceptance_criteria="$3"
    
    echo -e "${BLUE}🔍 Validating task creation inputs...${NC}"
    echo
    
    # Validate title
    if ! validate_input_quality "$title" $MIN_TITLE_WORDS "Task Title" true; then
        return 1
    fi
    
    # Validate description
    if ! validate_input_quality "$description" $MIN_DESCRIPTION_WORDS "Task Description" true; then
        return 1
    fi
    
    # Validate acceptance criteria if provided
    if [[ -n "$acceptance_criteria" ]]; then
        if ! validate_input_quality "$acceptance_criteria" $MIN_ACCEPTANCE_CRITERIA_WORDS "Acceptance Criteria" true; then
            return 1
        fi
    else
        echo -e "${YELLOW}⚠️  WARNING: No acceptance criteria provided. How will you know when this task is complete?${NC}"
        read -p "Continue without acceptance criteria? (y/N): " -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${RED}🚫 Cancelled. Please provide acceptance criteria.${NC}"
            return 1
        fi
    fi
    
    # Check project quality history
    if ! check_project_quality_history; then
        return 1
    fi
    
    # Log quality metrics
    local combined_text="$title $description $acceptance_criteria"
    local quality_score
    quality_score=$(calculate_quality_score "$combined_text" $MIN_DESCRIPTION_WORDS "Combined Task Input")
    local word_count
    word_count=$(count_meaningful_words "$combined_text")
    
    log_quality_metrics "task_creation" "$quality_score" "$word_count"
    
    echo -e "${GREEN}✅ Task creation validation passed!${NC}"
    return 0
}

# Export functions for use in other scripts
export -f count_meaningful_words
export -f calculate_quality_score
export -f validate_input_quality
export -f validate_project_manifest
export -f check_project_quality_history
export -f log_quality_metrics
export -f generate_quality_report
export -f validate_task_creation