#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
HTML 파일에서 ABAP 코드를 추출하여 .abap 파일로 변환하는 스크립트
"""

import os
import re
import html
from pathlib import Path
from bs4 import BeautifulSoup

def extract_abap_from_html(html_file_path):
    """HTML 파일에서 ABAP 코드를 추출"""
    try:
        with open(html_file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        
        soup = BeautifulSoup(content, 'html.parser')
        
        # code와 codeComment div 찾기
        code_divs = soup.find_all(['div'], class_=['code', 'codeComment'])
        
        abap_code = []
        for div in code_divs:
            # 텍스트 추출
            text = div.get_text(separator='\n', strip=False)
            # HTML 엔티티 디코딩
            text = html.unescape(text)
            # 연속된 공백 정리
            lines = text.split('\n')
            cleaned_lines = []
            for line in lines:
                # 줄 끝 공백 제거
                line = line.rstrip()
                # 빈 줄은 유지
                cleaned_lines.append(line)
            
            abap_code.extend(cleaned_lines)
            abap_code.append('')  # div 사이에 빈 줄 추가
        
        # 마지막 빈 줄 제거
        while abap_code and not abap_code[-1].strip():
            abap_code.pop()
        
        return '\n'.join(abap_code)
    
    except Exception as e:
        print(f"Error processing {html_file_path}: {e}")
        return None

def convert_html_to_abap(html_file_path, output_dir=None):
    """HTML 파일을 ABAP 파일로 변환"""
    html_path = Path(html_file_path)
    
    # 출력 디렉토리 설정
    if output_dir:
        output_path = Path(output_dir) / html_path.parent.name
        output_path.mkdir(parents=True, exist_ok=True)
    else:
        output_path = html_path.parent
    
    # ABAP 코드 추출
    abap_code = extract_abap_from_html(html_file_path)
    
    if abap_code is None:
        return False
    
    # 출력 파일명 생성 (.html -> .abap)
    abap_filename = html_path.stem + '.abap'
    abap_file_path = output_path / abap_filename
    
    # ABAP 파일 저장
    try:
        with open(abap_file_path, 'w', encoding='utf-8') as f:
            f.write(abap_code)
        return True
    except Exception as e:
        print(f"Error writing {abap_file_path}: {e}")
        return False

def process_directory(root_dir, replace_html=False):
    """디렉토리 내의 모든 HTML 파일을 변환"""
    root_path = Path(root_dir)
    html_files = list(root_path.rglob('*.html'))
    
    converted_count = 0
    failed_count = 0
    
    print(f"Found {len(html_files)} HTML files to convert...")
    
    for html_file in html_files:
        # .git 폴더 제외
        if '.git' in html_file.parts:
            continue
        
        # 변환
        if convert_html_to_abap(html_file):
            converted_count += 1
            if replace_html:
                # HTML 파일 삭제
                try:
                    html_file.unlink()
                except Exception as e:
                    print(f"Error deleting {html_file}: {e}")
        else:
            failed_count += 1
        
        # 진행 상황 출력 (100개마다)
        if (converted_count + failed_count) % 100 == 0:
            print(f"Processed {converted_count + failed_count}/{len(html_files)} files...")
    
    print(f"\nConversion complete!")
    print(f"  Converted: {converted_count}")
    print(f"  Failed: {failed_count}")
    
    return converted_count, failed_count

if __name__ == '__main__':
    import sys
    
    # 현재 스크립트 위치 기준으로 SAP_CO_OP_TRACK_25_2 디렉토리 찾기
    script_dir = Path(__file__).parent
    target_dir = script_dir
    
    # HTML 파일 교체 여부 확인
    replace_html = '--replace' in sys.argv or '-r' in sys.argv
    
    if replace_html:
        response = input("⚠️  HTML 파일을 삭제하고 .abap 파일로 교체하시겠습니까? (yes/no): ")
        if response.lower() != 'yes':
            print("취소되었습니다.")
            sys.exit(0)
    
    print(f"Converting HTML files in: {target_dir}")
    print(f"Replace HTML files: {replace_html}\n")
    
    process_directory(target_dir, replace_html=replace_html)


